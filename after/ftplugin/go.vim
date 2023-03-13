" go commands
nnoremap <leader>gt :call GoTestifyRun()<CR>
nnoremap <leader>gf :call GoFmt()<CR>

au FileType go setlocal makeprg=$HOME/go/bin/golangci-lint\ run\ --config\ $HOME/.golang-lint.yml
let go_highlight_all = 1

func! GoFmt()
	let saved_view = winsaveview()
	silent %!goimports
	if v:shell_error > 0
		cexpr getline(1, '$')->map({ idx, val -> val->substitute('<standard input>', expand('%'), '') })
		silent undo
		cwindow
	endif
	call winrestview(saved_view)
endfunc

func! GoGetTestName() abort
	" search flags legend (used only)
	" 'b' search backward instead of forward
	" 'c' accept a match at the cursor position
	" 'n' do Not move the cursor
	" 'W' don't wrap around the end of the file
	"
	" for the full list
	" :help search
	let l:funcline = search('func \(Test\|Example\)', "bcnW")
	let l:methline = search(') \(Test\|Example\)', 'bcnW')

	if l:funcline == 0
		return ''
	endif

	if l:methline > 0
		let l:funcdecl = getline(l:funcline)
		let l:methdecl = getline(l:methline)
		let l:funcname = split(split(l:funcdecl, " ")[1], "(")[0]
		let l:methname = split(split(l:methdecl, " ")[3], "(")[0]
		return join([l:funcname, l:methname], '/')
	endif

	let l:funcname = getline(l:funcline)
	return split(split(l:funcname, " ")[1], "(")[0]
endfunc

func! GoTestifyRun() abort
	let l:fulltestname = GoGetTestName()
	let l:suitename = split(l:fulltestname, '/')[0]
	let l:testname = split(l:fulltestname, '/')[1]
	let l:relpackage = expand("%:h")
	exec 'term++shell go test -v ./' .. l:relpackage .. '/... -run ^' .. l:suitename .. '$ -testify.m ^' .. l:testname .. '$'
	" TODO: add coloring that shows test passed or failed
	" if v:shell_error != 0
	"	match Error /l:testname/
endfunc
