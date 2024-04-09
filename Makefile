.PHONY: build
build:
	docker build -t gobox .
	docker images | grep gobox | sed -E 's/[ ]+/,/g' | rev | cut -d',' -f1 | rev

.PHONY: install
install:
	srcdir=$(pwd)
	mkdir -p ~/.vim/ ~/.vim/autoload/
	cp -fr after ~/.vim/after/
	cp vimrc ~/.vimrc
	cp scripts/* ~/bin/

.PHONY: plugins
plugins: install
	wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
	vim +PlugUpdate +qall
	cd ~/.vim/plugged/vimspector/ && ./install_gadget.py --verbose --enable-python --enable-bash
	mkdir -p ~/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/ ~/.vim/plugged/vimspector/configurations/linux/go/
	cp resources/go.gadgets.json ~/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/go.json
	cp resources/go.vimspector.json ~/.vim/plugged/vimspector/configurations/linux/go/default.json
