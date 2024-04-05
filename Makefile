.PHONY: build
build:
	docker build -t gobox .
	docker images | grep gobox | sed -E 's/[ ]+/,/g' | rev | cut -d',' -f1 | rev

.PHONY: install
install:
	mkdir -p ~/.vim/ ~/.vim/autoload/
	cp -fr after ~/.vim/after/
	cp vimrc ~/.vimrc
	wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
	vim +PlugUpdate +qall
