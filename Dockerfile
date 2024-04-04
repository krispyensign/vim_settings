######################################################################################################################
# build and install vim
FROM debian:bookworm-slim AS vimbuild

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	rm -f /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
	&& apt update \
	&& apt install --no-install-recommends -y \
		make gcc libtool-bin python3-dev libncurses-dev pkg-config autoconf automake \
		python3-docutils libseccomp-dev libjansson-dev libyaml-dev libxml2-dev

ADD --keep-git-dir=true https://github.com/universal-ctags/ctags.git /ctags/
WORKDIR /ctags
RUN ./autogen.sh \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install

ADD --keep-git-dir=true https://github.com/vim/vim.git /vim/
WORKDIR /vim
RUN ./configure --prefix=/usr/local --disable-gui --enable-python3interp \
	&& make \
	&& make install

######################################################################################################################
# build and install vimspector
FROM debian:bookworm-slim AS vimspectorbuild

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	rm -f /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
	&& apt update && apt install -y make gcc libtool-bin python3-dev libncurses-dev pip --no-install-recommends

# install vimspector gadgets
RUN mkdir -p /root/.vim/plugged/
WORKDIR /root/.vim/plugged/
ADD --keep-git-dir=true https://github.com/puremourning/vimspector.git vimspector/
WORKDIR /root/.vim/plugged/vimspector/
RUN ./install_gadget.py --verbose --enable-python --enable-bash
ADD resources/go.gadgets.json gadgets/linux/.gadgets.d/go.json
ADD resources/go.vimspector.json configurations/linux/go/default.json

######################################################################################################################
# build base vimbox
FROM debian:bookworm-slim AS vimbox

ARG python_version=3.11

# copy everything over
COPY --from=vimbuild /usr/local /usr/local/
COPY scripts/ /root/bin/
ENV PATH="${PATH}:/root/bin"
ADD https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh install.sh

# refresh certs and install everything
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	rm -f /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
	&& apt update \
	&& apt install -y --no-install-recommends \
		git libncurses6 python3 python-is-python3 pip \
		libpython${python_version} jq openssh-client make \
		curl wget ca-certificates openssl zsh ripgrep \
		docker.io python3-docutils libseccomp2 libjansson4 libxml2 libyaml-0-2 \
	&& sh install.sh --unatttended \
	&& echo 'set -o vi' >> /root/.zshrc \
	&& mkdir -p /root/.vim/autoload /src/

# setup vim
ADD https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim /root/.vim/autoload/plug.vim
COPY after/ /root/.vim/after/
COPY vimrc /root/.vimrc
COPY --from=vimspectorbuild /root/.vim/plugged/vimspector/ /root/.vim/plugged/vimspector/
RUN vim +PlugUpdate +qall

######################################################################################################################
# build gobox
FROM vimbox AS gobox

ARG cert_location=/usr/local/share/ca-certificates
ARG go_version=1.22.1
ENV PATH="${PATH}:/usr/local/go/bin:/root/go/bin"
ENV GOSUMDB="off"
ENV GOPROXY="direct"
ENV GIT_SSL_NO_VERIFY=true

# install go
ADD https://go.dev/dl/go${go_version}.linux-amd64.tar.gz go${go_version}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${go_version}.linux-amd64.tar.gz \
	&& rm go${go_version}.linux-amd64.tar.gz

# install go certs
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt,sharing=locked \
	rm -f /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache \
	&& apt --allow-releaseinfo-change update \
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
