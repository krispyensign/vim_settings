FROM debian:latest AS base

ARG cert_location=/usr/local/share/ca-certificates

# create a base build with apt caching enabled
RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
	echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=aptcache \
	--mount=type=cache,target=/var/lib/apt,sharing=locked,id=aptlib \
	apt update && apt install -y git libncurses6 python3 python-is-python3 pip jq

RUN <<EOH
	set -ex
	cat <<-EOF > /usr/local/bin/add-keys
		#!/bin/bash
		ls ~/.ssh | grep 'id' | grep -v 'pub' | sed 's%^%IdentityFile ~/.ssh/%' >> /etc/ssh/ssh_config
	EOF
	chmod +x /usr/local/bin/add-keys

	cat <<-EOF > /usr/local/bin/get-latest-version
		#!/bin/bash
		curl --silent "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name
	EOF
	chmod +x /usr/local/bin/get-latest-version
EOH

# build and install vim
FROM base AS vimbuild
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=aptcache \
	--mount=type=cache,target=/var/lib/apt,sharing=locked,id=aptlib \
	apt install -y make gcc libtool-bin python3-dev libncurses-dev
ADD --keep-git-dir=true https://github.com/vim/vim.git /vim
WORKDIR vim
RUN ./configure --prefix=/usr/local --disable-gui --enable-python3interp \
	&& make \
	&& make install

# build devbox
FROM base AS final
COPY --from=vimbuild /usr/local /usr/local/

# install dev apt packages
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=aptcache \
	--mount=type=cache,target=/var/lib/apt,sharing=locked,id=aptlib \
	apt install -y universal-ctags curl wget ca-certificates openssl zsh ripgrep

# setup zsh and shell keys script
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
	&& sh install.sh --unatttended \
	&& rm install.sh \
	&& chsh -s $(which zsh)

# install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install go
RUN wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz \
	&& tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz \
	&& rm go1.22.1.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin:/root/go/bin"
ENV GOSUMDB="off"
ENV GOPROXY="direct"
RUN apt --allow-releaseinfo-change update \
	&& apt upgrade -y \
	&& apt install -y --reinstall ca-certificates \
	&& git config --global http.sslverify false \
	&& export cert_location=/usr/local/share/ca-certificates \
	&& openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null \
		| openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt \
	&& openssl s_client -showcerts -connect sum.golang.org:443 </dev/null 2>/dev/null \
		| openssl x509 -outform PEM >  ${cert_location}/sum.golang.crt \
	&& openssl s_client -showcerts -connect gopkg.in:443 </dev/null 2>/dev/null \
		| openssl x509 -outform PEM >  ${cert_location}/gopkg.in.crt \
	&& update-ca-certificates
RUN --mount=type=cache,target=/root/go/pkg \
	&& go install -v -x -a gotest.tools/gotestsum@latest \
	&& go install -v -x -a github.com/alexec/junit2html@latest \
	&& go install -v -x -a github.com/go-delve/delve/cmd/dlv@latest
RUN --mount=type=cache,target=/root/go/pkg \
	mkdir -p /root/.vim/contrib \
	&& golangci_version=$(curl --silent "https://api.github.com/repos/golangci/golangci-lint/releases/latest" | jq -r .tag_name) \
	&& golangci_path=$(go env GOPATH)/bin \
	&& curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
		| sh -s -- -b ${golangci_path} ${golangci_version}

# setup vim plugin infra
RUN mkdir -p /root/.vim/autoload /src/ \
	&& curl -fLo /root/.vim/autoload/plug.vim \
		--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# setup vim
COPY after/ /root/.vim/after/
COPY vimrc /root/.vimrc
RUN vim +PlugUpdate +qall

RUN mkdir -p /src/
WORKDIR /src/

