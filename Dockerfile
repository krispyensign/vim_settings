######################################################################################################################
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
		vim-gtk3 \
		man-db \
		less

# install zsh
ADD https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh install.sh
RUN sh install.sh --unattended \
	&& echo 'set -o vi' >> /root/.zshrc \
	&& rm install.sh
RUN chsh -s /usr/bin/zsh

# install ctags
ADD https://github.com/universal-ctags/ctags.git /ctags/
RUN cd /ctags \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install \
 	&& cd .. \
	&& rm -fr /ctags

# install vimspector
ADD https://github.com/puremourning/vimspector.git /root/.vim/plugged/vimspector
RUN cd ${HOME}/.vim/plugged/vimspector/ && ./install_gadget.py --verbose --enable-python --enable-bash

# install vim-plug
ADD https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim /root/.vim/autoload/plug.vim

# default to zsh
CMD ["/usr/bin/zsh"]

######################################################################################################################
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
	&& apt update \
	&& apt install -y --no-install-recommends golang

# install go certs
RUN openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null \
 		| openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt \
 	&& openssl s_client -showcerts -connect sum.golang.org:443 </dev/null 2>/dev/null \
 		| openssl x509 -outform PEM >  ${cert_location}/sum.golang.crt \
 	&& openssl s_client -showcerts -connect gopkg.in:443 </dev/null 2>/dev/null \
 		| openssl x509 -outform PEM >  ${cert_location}/gopkg.in.crt \
 	&& update-ca-certificates

# finalize vim installation
ADD vimrc /root/.vimrc
RUN vim +PlugUpdate +qall
ADD . /settings/
RUN cd /settings/ && make install
