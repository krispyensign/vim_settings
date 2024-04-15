" gomod.vim
" ftplugin to handle go mod stuff


" run go mod tidy and then rebuild tags with latest runtimes
function! GoModRebuildRuntimeTags()
	" filter the lines accordingly
	exec !go mod tidy
	let lines = readfile(trim(system('go env GOMOD')))
	let filteredLines = []
	for line in lines
		if line =~ '/.*v'
			let filteredline = substitute(line, '// indirect', '', '')
			let filteredline = substitute(filteredline, '^[[:space:]]*', trim(system('go env GOMODCACHE')) .. '/', '')
			let filteredline = substitute(filteredline, ' ', '@', '')
			let filteredline = substitute(filteredline, '[[:space:]]*$', '/', '')
			let filteredLines = add(filteredLines, filteredline)
		endif
	endfor
	let files = join(filteredLines, ' ')
	echo files
	exec "!rg --glob \*.go --files" files "| ctags --sort=yes --recurse=yes --extras=+qfr -L -"
endfunction
