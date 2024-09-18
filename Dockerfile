######################################################################################################################
# base image
FROM debian:unstable-slim AS base

ENV PATH="${PATH}:/root/bin"

# install vim and python and other dev tools
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	rm -f /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
	&& apt update \
	&& apt install -y --no-install-recommends \
		python3-dev \
		make \
		gcc \
		libtool-bin \
		libncurses-dev \
		pip \
		python-is-python3 \
		python3-docutils \
		ca-certificates \
		openssl \
		curl \
		wget \
		openssh-client \
		autoconf \
		automake \
		pkg-config \
		manpages \
		python3-setuptools \
		git \
		jq \
		zsh \
		ripgrep \
		docker.io \
		vim-gtk3

# install ctags
RUN git clone https://github.com/universal-ctags/ctags.git /ctags/ \
	&& cd /ctags \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install \
 	&& cd .. \
	&& rm -fr /ctags

# install zsh
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
	&& sh install.sh --unattended \
	&& echo 'set -o vi' >> /root/.zshrc \
	&& mkdir -p /root/.vim/autoload /src/

# install vimspector
RUN mkdir -p /root/.vim/plugged/ \
	&& cd /root/.vim/plugged/ \
	&& git clone https://github.com/puremourning/vimspector.git vimspector/ \
	&& cd vimspector \
	&& ./install_gadget.py --verbose --enable-python --enable-bash

# add vim plug
ADD https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim /root/.vim/autoload/plug.vim

######################################################################################################################
# build gobox-base
FROM base AS gobox

ARG cert_location=/usr/local/share/ca-certificates
ENV PATH="${PATH}:/usr/local/go/bin:/root/go/bin"
ENV GOSUMDB="off"
ENV GOPROXY="direct"
ENV GIT_SSL_NO_VERIFY=true

# install latest go
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	rm -f /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
	&& apt update && apt install -y --no-install-recommends golang

# install go certs
RUN openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null \
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

# finalize vim installation
ADD . /settings/
RUN cd /settings/ && make install
