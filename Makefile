.PHONY: all
all:

.PHONY: install
install:
	mkdir -p \
		${HOME}/bin/ \
		${HOME}/.vim/ \
		${HOME}/.vim/autoload/ \
		${HOME}/.vim/after/ \
		${HOME}/.vim/scripts/ \
		${HOME}/.vim/colors/
	cp vimrc ${HOME}/.vimrc
	cp -fr after/* ${HOME}/.vim/after/
	cp -fr scripts/* ${HOME}/.vim/scripts/
	cp -fr colors/* ${HOME}/.vim/colors/

.PHONY: install-plugins
install-plugins: install
	vim +PlugUpdate +qall

.PHONY: install-vimspector
install-vimspector: install
	mkdir -p \
		${HOME}/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/ \
		${HOME}/.vim/plugged/vimspector/configurations/linux/go/ \
		${HOME}/.vim/plugged/vimspector/gadgets/macos/.gadgets.d/ \
		${HOME}/.vim/plugged/vimspector/configurations/macos/go/
	cd ${HOME}/.vim/plugged/vimspector/ \
		&& python install_gadget.py \
			--verbose \
			--enable-python \
			--enable-bash
	cp resources/go.gadgets.json ${HOME}/.vim/plugged/vimspector/gadgets/linux/.gadgets.d/go.json
	cp resources/go.vimspector.json ${HOME}/.vim/plugged/vimspector/configurations/linux/go/default.json
	cp resources/go.gadgets.json ${HOME}/.vim/plugged/vimspector/gadgets/macos/.gadgets.d/go.json
	cp resources/go.vimspector.json ${HOME}/.vim/plugged/vimspector/configurations/macos/go/default.json
