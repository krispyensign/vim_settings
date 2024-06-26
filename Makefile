.PHONY: install
install:
	mkdir -p ${HOME}/.vim/ ${HOME}/.vim/autoload/ ${HOME}/.vim/after/
	cp -fr after/* ${HOME}/.vim/after/
	cp vimrc ${HOME}/.vimrc
	cp scripts/* ${HOME}/bin/

.PHONY: build
build:
	docker build -t gobox .
	docker images | grep gobox | sed -E 's/[ ]+/,/g' | rev | cut -d',' -f1 | rev

.PHONY: plugins
plugins: install
	vim +PlugUpdate +qall
	cd ${HOME}/.vim/plugged/vimspector/ && ./install_gadget.py --verbose --enable-python --enable-bash
	mkdir -p ${HOME}/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/ ${HOME}/.vim/plugged/vimspector/configurations/linux/go/
	cp resources/go.gadgets.json ${HOME}/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/go.json
	cp resources/go.vimspector.json ${HOME}/.vim/plugged/vimspector/configurations/linux/go/default.json
