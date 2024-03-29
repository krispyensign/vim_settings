let b:ale_disable_lsp = 1

func! GoLint() abort
	let l:lintcommand = $HOME.."/go/bin/golangci-lint run --config "..$HOME.."/.golang-lint.yml | sed -e '/^[[:space:]]*$/d'"
	cexpr! system(l:lintcommand)
endfunc

func! GoRunTestifyTest() abort
	let l:relpackage = './'..expand("%:h")..'/...'
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
	let l:command = "go test -timeout 30s".." "..l:relpackage.." -run "..l:suitename..' -testify.m '..l:testname
	echo l:command
	cexpr! system(l:command)
endfunc

