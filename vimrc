" {{{1 Top Level Settings
set nocompatible									" be iMproved, required
syntax on											" enable syntax highlighting
filetype plugin indent on							" allow filetype to be completely managed by vim
set encoding=utf8									" default encoding
set nowrap											" no text wrap
set number											" turn on numbering
set foldenable										" turn on folding
set signcolumn=yes									" gutter enabled
set backspace=indent,eol,start						" enable backspace key
set guioptions=gm									" enable menu only
set clipboard^=unnamed,unnamedplus					" setup clipboard to be more integrated
set ttyfast											" speed things up with tty
set cmdheight=2										" command line bar is 2 chars high
set noshowmode										" managed by airline instead
set noshowmatch										" do not try to jump to braces
set switchbuf+=usetab,newtab						" default commands to start a new tab
set mouse=a											" enable mouse integrations for tty
set ttymouse=sgr									" more tty integrations for mouse
set cursorline										" enable visual line for for cursor
set tabstop=4										" make sure if tabs are used it displays 4 and not 8
set shiftwidth=4									" shifts should also display as 4
set sessionoptions-=folds,buffers					" don't try to store buggy stuff in a session
set hlsearch										" enable highlighting during search
set listchars=eol:⏎,tab:▸\ ,trail:␠,nbsp:⎵,space:.	" set whitespace chars
set showfulltag										" show tag context in popup
set nobackup										" no swaps or backups
set nowritebackup									" no swaps or backups
set noswapfile										" no swaps or backups
au FileType vim,txt setlocal foldmethod=marker		" if vim then enable marker folding

" {{{1 TODO:
" ctags with filename and type in popup
" ctags auto regenerated
" ctags completion with fzf
" ctags completion with struct context

" {{{1 Plugins

" {{{2 setup
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

command! PU PlugUpgrade | PlugUpdate

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'

" {{{2 general language plugins
Plug 'majutsushi/tagbar', { 'on' : 'TagbarToggle' }
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector', { 'on': 'VimspectorBreakpoints' }

" {{{2 language specific plugins
Plug 'hashivim/vim-terraform', { 'for' : 'terraform' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'preservim/vim-markdown', { 'for' : ['markdown', 'vim-plug'] }
Plug 'vito-c/jq.vim', { 'for' : 'jq' }
Plug 'jackielii/vim-gomod', { 'for' : ['gomod', 'gosum'] }
Plug 'OmniSharp/omnisharp-vim'

" {{{2 AI
Plug 'Exafunction/codeium.vim', { 'branch': 'main', 'on': 'Codeium' }

" {{{2 navigation plugins
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" {{{2 git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Eliot00/git-lens.vim'

" {{{2 supplemental theme plugins
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline-themes'

" {{{2 theme tools
Plug 'guns/xterm-color-table.vim'
Plug 'vim-scripts/hexHighlight.vim'
Plug 'lifepillar/vim-colortemplate'
"Plug 'jaxbot/semantic-highlight.vim'

" {{{2 themes
Plug 'junegunn/seoul256.vim'
Plug 'jsit/toast.vim'
Plug 'vigoux/oak'
Plug 'zacanger/angr.vim'
Plug 'artanikin/vim-synthwave84'
Plug 'sainnhe/everforest'
Plug 'christianrickert/vim-firefly'
Plug 'timmajani/tokyonightnoir-vim'
Plug 'm6vrm/gruber.vim'
Plug 'vim/colorschemes'

call plug#end()

" {{{1 Colors
" {{{2 color settings
set termguicolors									" enable 24bit
set background=dark									" dark mode

" {{{2 enable colorcolumn
if (exists('+colorcolumn'))
	set colorcolumn=80,100,120
endif

" {{{2 enable built-in language highlighting
" {{{3 python
let g:python_highlight_all = 1

" {{{3 golang
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

" {{{3 fortran
let g:fortran_more_precise = 1
let g:fortran_free_source = 1

" {{{3 ada
let g:ada_standard_types = 1

" {{{2 configure themes
let g:seoul256_background = 234
let g:airline_theme = 'simple'
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

" {{{2 semantic highlighting overrides
let g:semanticBlacklistOverride = {
\    'ada': [
\        'procedure', 'begin', 'is', 'end', 'function', 'return', 'constant',
\        'if', 'then', 'raise', 'type', 'record', 'with', 'pragma', 'use',
\        'renames', 'package', 'Float', 'String', 'Program_Error', 'for',
\        'declare', 'loop', 'in', 'array', 'range', 'with', 'private',
\        'protected', 'and', 'in', 'out', 'of', 'True', 'False', 'body', 'use',
\        'new', 'Positive', 'Boolean', 'Integer', 'tagged', 'subtype', 'not',
\        'null', 'access', 'all'
\    ]
\}

" let g:semanticEnableFileTypes = ['ada']

let g:semanticGUIColors = [
\ '#9CD8F7', '#F97C65', '#35D27F', '#EB75D6', '#8997F5',
\ '#D49DA5', '#7FEC35', '#F6B223', '#B4F1C3', '#99B730', '#F67C1B', '#3AC6BE',
\ '#EAAFF1', '#DE9A4E', '#BBEA87', '#EEF06D', '#8FB272', '#EAA481', '#F58AAE',
\ '#80B09B', '#5DE866', '#B5A5C5', '#88ADE6', '#4DAABD', '#EDD528', '#FA6BB2',
\ '#47F2D4', '#F47F86', '#2ED8FF', '#B8E01C', '#C5A127', '#74BB46', '#D386F1',
\ '#97DFD6', '#B1A96F', '#66BB75', '#97AA49', '#EF874A', '#48EDF0', '#C0AE50',
\ '#89AAB6', '#D7D1EB', '#5EB894', '#57F0AC', '#B5AF1B', '#B7A5F0', '#8BE289',
\ '#D38AC6', '#C8EE63', '#ED9C36', '#85BA5F', '#9DEA74', '#85C52D', '#40B7E5',
\ '#EEA3C2', '#7CE9B6', '#8CEC58', '#D8A66C', '#51C03B', '#C4CE64', '#45E648',
\ '#4DC15E', '#63A5F3', '#EA8C66', '#D2D43E', '#E5BCE8', '#E4B7CB', '#B092F4',
\ '#44C58C', '#D1E998', '#76E4F2', '#E19392', '#A8E5A4', '#BF9FD6', '#E8C25B',
\ '#58F596', '#6BAEAC', '#94C291', '#7EF1DB', '#E8D65C', '#A7EA38', '#D38AE0',
\ '#5CD8B8', '#B6BF6B', '#BEE1F1', '#B1D43E', '#84A5CD',
\ '#CFEF7A', '#A3C557', '#E4BB34', '#ECB151', '#BDC9F2', '#5EB0E9', '#E09764',
\ '#9BE3C8', '#B3ADDC', '#B2AC36', '#C8CD4F', '#C797AF', '#DCDB26', '#BCA85E',
\ '#E495A5', '#F37DB8', '#70C0B1', '#5AED7D', '#E49482', '#8AA1F0', '#B3EDEE',
\ '#DAEE34', '#EBD646', '#ECA2D2', '#A0A7E6', '#3EBFD3', '#C098BF', '#F1882E',
\ '#77BFDF', '#7FBFC7', '#D4951F', '#A5C0D0', '#B892DE', '#F8CB31', '#75D0D9',
\ '#A6A0B4', '#EA98E4', '#F38BE6', '#DC83A4']


" {{{2 syntax helpers
func! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

func! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunc

func! SynReset()
	:syntax reset
	:syntax off
	:syntax on
endfunc

" {{{2 turn on the colors
try
	colorscheme	arabica
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme evening
endtry

" {{{1 Cheatsheet for randos
" C-w N  =>terminal Normal mode
" C-w "" =>paste terminal
" C-r C-w =>paste command
" [[  => jump to function header
" C-w x =>switch files during diff this
" C-w r =>rotate files
" C-] =>jump to tag in ctags or follow link in help file
" C-o =>jump back
" C-x C-o =>omnifunc
" C-x C-u =>completefunc
" C-x C-] =>complete tags
" 1gd =>jump to local var
" * =>search for whole word under cursor
" # =>search for partial word under cursor

" {{{1 General Custom Shortcuts
" leader remap for ergonomic
let mapleader = ' '

" {{{2 navigation maps
nnoremap <silent> <leader><Up> :wincmd k<CR>
nnoremap <silent> <leader><Down> :wincmd j<CR>
nnoremap <silent> <leader><Left> :wincmd h<CR>
nnoremap <silent> <leader><Right> :wincmd l<CR>
nnoremap <silent> <leader>[ :vertical resize +5<CR>
nnoremap <silent> <leader>] :vertical resize -5<CR>
nnoremap <silent> <leader>* :nohls<CR>

" {{{2 toggles
nnoremap <leader>n :15Lexplore<CR>
nnoremap <leader>p :pclose<CR>
nnoremap <leader>h :helpclose<CR>
nnoremap <leader>i :set invlist<CR>
nnoremap <leader>ff :set guifont=Menlo-Regular:h10

" {{{1 Fugitive
nnoremap <leader>s :call ToggleGstatus()<CR>
func! ToggleGstatus() abort
	if CloseGstatus() == 1
		return
	endif
	keepalt abo Git
endfunc

func! CloseGstatus() abort
	let l:gstatus_bufname = 'fugitive://' .. getcwd() .. '/.git//'
	if bufexists(l:gstatus_bufname)
		let l:nr = bufnr(l:gstatus_bufname)
		try
			exe 'bd' l:nr
			return 1
		catch
		endtry
	endif
	return 0
endfun

" {{{1 Git-Lens
let g:GIT_LENS_ENABLED = 1

" {{{1 Rainbow
let g:rainbow_active = 1

" {{{1 Airline

" {{{2 tabline
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" {{{2 branch
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#format = 1

" {{{2 fugitive
let g:airline#extensions#fugitiveline#enabled = 1

" {{{2 tagbar
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#searchmethod = 'scoped-stl'
let g:airline#extensions#tagbar#max_filesize = 2048*1024

" {{{2 general
let g:airline_powerline_fonts = 0
let g:airline_experimental = 1
let g:airline_highlighting_cache = 1
let g:airline_extensions = ['tabline', 'branch', 'fugitiveline', 'fzf',
\	'tagbar', 'virtualenv', 'whitespace', 'term', 'ale']

" {{{1 Tagbar
nnoremap <leader>tt :TagbarToggle<CR>
let g:tagbar_autoclose_netrw = 1

" {{{1 Netrw
let g:netrw_list_hide = '.*\.swp$,\.git/'
let g:netrw_hide = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_mousemaps = 0
let g:netrw_fastbrowse = 0
let g:netrw_special_syntax = 1

" {{{1 ALE
set omnifunc=ale#completion#OmniFunc
set completeopt=menu,menuone,preview,popup,noselect,noinsert
inoremap <C-space> <C-X><C-O>
nnoremap <F12> :ALEGoToDefinition -split
" {{{2 completion and fixing

let g:ale_completion_enabled = 1	" enable ale completion
let g:ale_completion_autoimport = 1 " allow ale to auto import if needed
let g:ale_completion_delay = 200	" delay some before running completion
let g:ale_lsp_suggestions = 1		" allow lsp suggestion
let g:ale_disable_lsp = 0			" always enable lsp
let g:ale_fix_on_save = 1			" attempt to run fixers on save

" {{{2 logging
let g:ale_history_log_output = 1
let g:ale_history_enabled = 1

" {{{2 error behavior
let g:ale_echo_msg_format='%linter%:%code: %%s' " show linter and code error so they can be fixed or silenced
let g:ale_warn_about_trailing_whitespace = 0	" do not annoy with whitespace warnings as these get fixed by formatter
let g:ale_max_signs = 100						" displays only so many error signs to improve performance slightly
let g:ale_set_highlights = 0					" disable squiggles that interfere with syntax highlighting
let g:ale_virtualtext_cursor = 'current'		" only show error for current line

" {{{2 ale behavior
let g:ale_detail_to_floating_preview = 1	" use floating preview of details
let g:ale_set_balloons = 1					" use balloons for hover information

" {{{2 language
let g:ale_python_auto_uv = 1
let g:ale_python_pylsp_auto_uv = 1
let g:ale_python_ruff_uv = 1
let g:ale_python_mypy_auto_uv = 1
let g:ale_python_mypy_options = '--strict'
let g:ale_go_golangci_lint_options = '--timeout 10m'
let g:ale_go_golangci_lint_package = 1
let g:ale_linters_ignore = {
\ 'cs' : ['csc', 'mcsc'],
\}
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'go': ['gofmt', 'goimports', 'gopls'],
\   'python': ['ruff'],
\}
let g:ale_linters = {
\	'cs': ['omnisharp'],
\	'go': ['golangci-lint', 'gofmt', 'gobuild', 'gopls'],
\	'python': ['mypy', 'pylsp', 'ruff'],
\   'ada': ['adals'],
\}

" {{{1 OmniSharp
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_ui_options = '--reverse --multi --ansi'
let g:OmniSharp_selector_ui_map = {
			\	'ctrl-t': 'tab split',
			\	'ctrl-x': 'split',
			\	'ctrl-v': 'vsplit',
			\}
let g:OmniSharp_server_use_mono = 0
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_server_start_server = 1
let g:OmniSharp_loglevel = 'debug'
let g:OmniSharp_diagnostic_listen = 2
let g:OmniSharp_diagnostic_showid = 1
let g:OmniSharp_diagnostic_exclude_paths = [
    \ 'obj\\',
    \ '[Tt]emp\\',
    \ '\.nuget\\',
    \ '\<AssemblyInfo\.cs\>'
    \]
let g:OmniSharp_highlight_groups = {
    \ 'Keyword': 'Keyword',
	\ 'LocalName': 'Special',
	\ 'ParameterName': 'None',
	\ 'FieldName': 'None',
\}

" {{{1 Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" {{{1 Codeium
let g:codeium_disable_bindings = 1
imap <script><silent><nowait><expr> <C-g> codeium#Accept()
let g:codeium_no_map_tab = 1

" {{{1 Generic Tags
" FZF / tag completion
" inoremap <C-space> <Left><C-O>:call TagCompl()<CR>
func! TagCompl() abort
	let l:result = fzf#vim#tags(expand("<cword>"), {'sink':function('s:compl_tag')})
endfunc

func! s:compl_tag(line)
	let fields = split(a:line, "\t")
	let cleanedFields = []
	for field in fields
		let cleanedFields = add(cleanedFields, trim(field))
	endfor

	echo cleanedFields
	let tagName = cleanedFields[0]
	echo tagName
	call setreg('0', tagName)
	if len(trim(expand("<cword>"))) == 0
		call feedkeys('"0p')
	else
		call feedkeys('viw"0p')
	endif
endfunc

func! UpdateTags() abort
	let job = job_start("echo " .. expand("%") .. "| ctags --append=yes --sort=yes --recurse=yes --extras=+qfr -L -")
	echo job
endfunc

" {{{1 FZF
" {{{2 s:build_quickfix_list
" An action can be a reference to a function that processes selected lines
func! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunc

" {{{2 g:fzf_action
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
\}

" {{{2 g:fzf_colors and g:fzf_layout
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'down': '30%' }

" {{{2 Rgl
" search for string by filetype
command! -bang -nargs=* Rgl
\	call fzf#vim#grep(
\		'rg --column --line-number --no-heading --color=always --smart-case --type ' ..
\			&filetype ..
\			' -- ' ..
\			shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

" {{{2 Rgg
" search for string by file extension
command! -bang -nargs=* Rgg
\	call fzf#vim#grep(
\		'rg --column --line-number --no-heading --color=always --smart-case --glob \*.' ..
\			expand('%:e') ..
\			' -- ' ..
\			shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)
