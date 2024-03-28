FROM debian:latest AS base

ARG cert_location=/usr/local/share/ca-certificates

RUN apt update
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=aptcache \
	--mount=type=cache,target=/var/lib/apt,sharing=locked,id=aptlib \
	apt install -y git make gcc libtool-bin libncurses-dev \
	python3 python-is-python3 pip ca-certificates openssl

FROM base AS vimbuild

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=aptcache \
	--mount=type=cache,target=/var/lib/apt,sharing=locked,id=aptlib \
	apt install -y python3-dev

RUN git clone https://github.com/vim/vim.git
WORKDIR vim
RUN ./configure --prefix=/usr/local --disable-gui --enable-python3interp && make && make install

FROM base AS final

COPY --from=vimbuild /usr/local /usr/local/

# install dev packages
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=aptcache \
	--mount=type=cache,target=/var/lib/apt,sharing=locked,id=aptlib \
	apt install -y golang alire cmake universal-ctags curl wget gnat gprbuild jq

# install go support
RUN openssl s_client -showcerts -connect github.com:443 </dev/null 2>/dev/null|openssl x509 -outform PEM > ${cert_location}/github.crt \
	&& openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt \
	&& openssl s_client -showcerts -connect golang.org:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >  ${cert_location}/golang.crt \
	&& openssl s_client -showcerts -connect gotest.tools:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >  ${cert_location}/gotest.crt \
	&& update-ca-certificates
RUN --mount=type=cache,target=/root/.cache/ \
	go install github.com/go-delve/delve/cmd/dlv@latest \
	&& go install golang.org/x/tools/gopls@latest \
	&& go install gotest.tools/gotestsum@latest
RUN --mount=type=cache,target=/root/.cache/ <<EOF
	mkdir -p /root/.vim/contrib
	golangci_version=$(curl --silent "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name "golangci/golangci-lint")
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh\
		| sh -s -- -b $(go env GOPATH)/bin ${golangci_version}
EOF

# setup vim plugin infra
RUN mkdir -p /root/.vim/autoload /src/ \
	&& curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# setup vim
COPY after/ /root/.vim/after/
COPY vimrc /root/.vimrc
RUN --mount=type=cache,id=vim,target=/root/.vim/plugged \
	vim +PlugUpdate +qall

# post install vimspector
WORKDIR /root/.vim/plugged/vimspector/
RUN --mount=type=cache,id=vim,target=/root/.vim/plugged \
	./install_gadget.py --verbose --force-enable-csharp --enable-python \
	--enable-go --enable-bash --enable-c \
	&& chmod -R u+rw ./

# post install you complete me
WORKDIR /root/.vim/plugged/YouCompleteMe/
RUN --mount=type=cache,id=vim,target=/root/.vim/plugged \
	./install.py --verbose --go-completer --clangd-completer --force-sudo \
	&& chmod -R u+rw ./

RUN mkdir -p /src/
WORKDIR /src/

