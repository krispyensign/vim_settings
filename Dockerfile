FROM debian:latest AS BASE

RUN apt update && apt install -y git make gcc libtool-bin libncurses-dev \
	python3 python-is-python3 python3-dev pip

FROM BASE AS VIMBUILD

RUN git clone https://github.com/vim/vim.git
WORKDIR vim
RUN ./configure --prefix=/usr/local --disable-gui --enable-python3interp
RUN make && make install

FROM BASE AS FINAL

COPY --from=VIMBUILD /usr/local /usr/local/

# setup packages
RUN apt update && apt install -y golang alire cmake universal-ctags curl wget \
	gnat gprbuild jq

# copy configs
RUN mkdir -p /root/.vim/autoload /root/.vim/contrib/ /src/
COPY after/ /root/.vim/after/
COPY vimrc /root/.vimrc

# setup plugin
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install everything
RUN vim +PlugUpdate +qall

# post install vimspector
WORKDIR /root/.vim/plugged/vimspector/
RUN ./install_gadget.py --verbose --force-enable-csharp --enable-python \
	--enable-go --enable-bash --enable-c && chmod -R u+rw ./

# post install you complete me
WORKDIR /root/.vim/plugged/YouCompleteMe/
RUN ./install.py --verbose --go-completer --clangd-completer --force-sudo \
	&& chmod -R u+rw ./

WORKDIR /src/

