" search for ref by file extension
command! -bang -nargs=* RgRef
\	call fzf#vim#grep(
\		'rg --column --line-number --no-heading --color=always --smart-case --pcre2 --glob \*.' ..
\			expand('%:e') ..
\			' -- ' ..
\			shellescape('^(?!//).*' .. expand('<cword>') .. '.*$'),
\		1, fzf#vim#with_preview(), <bang>0)

" if ale isn't available then this can be used to populate the quick fix
" instead
func! GoLint() abort
	let l:lintcommand = "golangci-lint run ./... | sed -e '/^[[:space:]]*$/d'"
	cexpr! system(l:lintcommand)
endfunc

" ale doesn't seem to support test checking
func! GoTestCheck() abort
	let l:lintcommand = "go test -c ./... 2>&1 | grep ':' | grep -v '#'"
	cexpr! system(l:lintcommand)
endfunc

func! GoRunTestifyTest() abort
	let l:relpackage = expand("%:h")
	let l:funcline = search('func \(Test\|Example\)', "bcnW")
	let l:methline = search(') \(Test\|Example\)', 'bcnW')

	if l:funcline == 0
		echo "no nearby suite detected. not running"
		return
	endif

	if l:methline == 0
		echo "no testify methods detected. not running"
		return
	endif

	let l:suitename = '^'..split(split(getline(l:funcline), " ")[1], "(")[0]..'$'
	let l:testname = '^'..split(split(getline(l:methline), " ")[3], "(")[0]..'$'
	let l:command = "go test -timeout 30s -run "..l:suitename..' -testify.m '..l:testname.." "..l:relpackage
	echo l:command
	cexpr! system(l:command)
endfunc

