######################################################################################################################
# build and install vim
FROM debian:latest AS vimbuild

RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
	echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt update && apt install -y make gcc libtool-bin python3-dev libncurses-dev --no-install-recommends

ADD --keep-git-dir=true https://github.com/vim/vim.git /vim
WORKDIR vim
RUN ./configure --prefix=/usr/local --disable-gui --enable-python3interp \
	&& make \
	&& make install

######################################################################################################################
# build and install vimspector
FROM debian:latest AS vimspectorbuild

RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
	echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt update && apt install -y make gcc libtool-bin python3-dev libncurses-dev pip --no-install-recommends

# install vimspector gadgets
RUN mkdir -p /root/.vim/plugged/
WORKDIR /root/.vim/plugged/
ADD --keep-git-dir=true https://github.com/puremourning/vimspector.git vimspector/
WORKDIR /root/.vim/plugged/vimspector/
RUN ./install_gadget.py --verbose --enable-c --enable-cpp --enable-python --enable-bash

######################################################################################################################
# build base vimbox
FROM debian:latest AS vimbox
COPY --from=vimbuild /usr/local /usr/local/

# create a base build with apt caching enabled
RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
	echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt --allow-releaseinfo-change update \
	&& apt upgrade -y \
	&& apt install -y git libncurses6 python3 python-is-python3 pip \
		libpython3-dev jq openssh-client make docker.io docker-compose \
		curl wget ca-certificates openssl zsh ripgrep universal-ctags --no-install-recommends


# install oh my zsh
ADD https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh install.sh
RUN sh install.sh --unatttended

# install fzf
ADD https://github.com/junegunn/fzf.git /root/.fzf/
RUN /root/.fzf/install

# install helper scripts
RUN <<EOH
	set -ex
	cat <<-EOF > /usr/local/bin/add-keys
		#!/bin/bash
		ls ~/.ssh | grep 'id' | grep -v 'pub' | sed 's%^%IdentityFile ~/.ssh/%' >> /etc/ssh/ssh_config
	EOF
	chmod +x /usr/local/bin/add-keys
EOH

# setup vim plugin infra
RUN mkdir -p /root/.vim/autoload /src/ \
	&& curl -fLo /root/.vim/autoload/plug.vim \
		--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# setup vim plugins
COPY after/ /root/.vim/after/
COPY vimrc /root/.vimrc
COPY --from=vimspectorbuild /root/.vim/plugged/vimspector/ /root/.vim/plugged/vimspector/
RUN vim +PlugUpdate +qall

######################################################################################################################
# build gobox
FROM vimbox AS gobox

ARG cert_location=/usr/local/share/ca-certificates
ARG go_version=1.22.1

# install go
ADD https://go.dev/dl/go${go_version}.linux-amd64.tar.gz go${go_version}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${go_version}.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin:/root/go/bin"
ENV GOSUMDB="off"
ENV GOPROXY="direct"
ENV GIT_SSL_NO_VERIFY=true

# update certs
RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
	echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	apt --allow-releaseinfo-change update \
	&& apt install -y --reinstall --no-install-recommends ca-certificates \
	&& openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null \
		| openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt \
	&& openssl s_client -showcerts -connect sum.golang.org:443 </dev/null 2>/dev/null \
		| openssl x509 -outform PEM >  ${cert_location}/sum.golang.crt \
	&& openssl s_client -showcerts -connect gopkg.in:443 </dev/null 2>/dev/null \
		| openssl x509 -outform PEM >  ${cert_location}/gopkg.in.crt \
	&& update-ca-certificates

# install go dev packages
RUN --mount=type=cache,target=/root/go/pkg --mount=type=cache,target=/root/.cache/go-build \
	go install -v -x -a gotest.tools/gotestsum@latest \
	&& go install -v -x -a github.com/alexec/junit2html@latest \
	&& go install -v -x -a github.com/go-delve/delve/cmd/dlv@latest \
	&& mkdir -p /root/.vim/contrib \
	&& golangci_version=$(curl --silent "https://api.github.com/repos/golangci/golangci-lint/releases/latest" | jq -r .tag_name) \
	&& golangci_path=$(go env GOPATH)/bin \
	&& curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
		| sh -s -- -b ${golangci_path} ${golangci_version}

