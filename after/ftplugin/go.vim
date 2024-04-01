" search for ref by file extension
command! -bang -nargs=* RgRefDebug
\	echo 'rg --column --line-number --no-heading --color=always --smart-case --pcre2 --glob \*.' ..
\			expand('%:e') ..
\			' -- ' ..
\			shellescape('^(?!//).*' .. expand('<cword>') .. '.*$')

command! -bang -nargs=* RgRef
\	call fzf#vim#grep(
\		'rg --column --line-number --no-heading --color=always --smart-case --pcre2 --glob \*.' ..
\			expand('%:e') ..
\			' -- ' ..
\			shellescape('^(?!//).*' .. expand('<cword>') .. '.*$'),
\		1, fzf#vim#with_preview(), <bang>0)

func! GoLint() abort
	let l:lintcommand = $HOME.."/go/bin/golangci-lint run --config "..$HOME.."/.golang-lint.yml | sed -e '/^[[:space:]]*$/d'"
	cexpr! system(l:lintcommand)
endfunc

func! GoRunTestifyTest() abort
	let l:relpackage = ..expand("%:h")
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

