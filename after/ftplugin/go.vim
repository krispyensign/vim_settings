" my homemade go plugin for vim. requires vim-test, vimspector, delve, and
" goimports


" Commands {{{
nnoremap <leader>gt :call GoTestifyRun()<CR>
nnoremap <leader>gf :call GoFmt()<CR>

au FileType go setlocal makeprg=$HOME/go/bin/golangci-lint\ run\ --config\ $HOME/.golang-lint.yml
" }}}

" Settings {{{
let go_highlight_all = 1
" }}}

" Testing {{{
func! GoRunTest() abort
	let l:relpackage = './'..expand("%:h")..'/...'
	let l:funcline = search('func \(Test\|Example\)', "bcnW")
	let l:methline = search(') \(Test\|Example\)', 'bcnW')

	if l:funcline == 0
		echo "no nearby test detected. not running"
		return
	endif

	if l:methline > 0
		let l:suitename = '^'..split(split(getline(l:funcline), " ")[1], "(")[0]..'$'
		let l:testname = '^'..split(split(getline(l:methline), " ")[3], "(")[0]..'$'
		exec 'Delve ' .. l:relplackage .. ' -- -test.run ' .. l:suite .. ' -testify.m ' .. l:testname
	endif

	let l:funcname = getline(l:funcline)
	let l:testname = '^'..split(split(l:funcname, " ")[1], "(")[0]..'$'
	exec 'Delve ' .. l:relplackage .. ' -- -test.run ' .. l:testname
endfunc
" }}}
