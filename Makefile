.PHONY: all
all:

.PHONY: install
install:
	mkdir -p \
		${HOME}/bin/ \
		${HOME}/.vim/ \
		${HOME}/.vim/autoload/ \
		${HOME}/.vim/after/ \
		${HOME}/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/ \
		${HOME}/.vim/plugged/vimspector/configurations/linux/go/ \
		${HOME}/.vim/plugged/vimspector/gadgets/macos/.gadgets.d/ \
		${HOME}/.vim/plugged/vimspector/configurations/macos/go/
	cp vimrc ${HOME}/.vimrc
	cp -fr after/* ${HOME}/.vim/after/
	cp scripts/ ${HOME}/.vim/scripts/
	cp resources/go.gadgets.json ${HOME}/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/go.json
	cp resources/go.vimspector.json ${HOME}/.vim/plugged/vimspector/configurations/linux/go/default.json
	cp resources/go.gadgets.json ${HOME}/.vim/plugged/vimspector/gadgets/macos/.gadgets.d/go.json
	cp resources/go.vimspector.json ${HOME}/.vim/plugged/vimspector/configurations/macos/go/default.json

.PHONY: build-gobox
build-gobox:
	DOCKER_BUILDKIT=1 docker build --target gobox -t gobox .
	docker images | grep gobox | sed -E 's/[ ]+/,/g' | rev | cut -d',' -f1 | rev
	cp vimbox ${HOME}/.vim/vimbox
	@echo 'Remember to "source ~/.vim/vimbox" when ready to use'

.PHONY: install-plugins
install-plugins: install
	vim +PlugUpdate +qall

.PHONY: install-vimspector
install-vimspector: install
	cd ${HOME}/.vim/plugged/vimspector/ && ./install_gadget.py --verbose --enable-python --enable-bash
