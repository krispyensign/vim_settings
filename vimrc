" {{{1 Top Level Settings
set nocompatible									" be iMproved, required
syntax on											" enable syntax highlighting
filetype plugin indent on 							" allow filetype to be completely managed by vim
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
set completeopt=menuone,popup,noinsert,noselect		" use popup instead of preview
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
" }}}
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
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'

" {{{2 language specific plugins
Plug 'hashivim/vim-terraform', { 'for' : 'terraform' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'preservim/vim-markdown', { 'for' : ['markdown', 'vim-plug'] }
Plug 'vito-c/jq.vim', { 'for' : 'jq' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'jackielii/vim-gomod', { 'for' : ['gomod', 'gosum'] }

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
Plug 'mnishz/colorscheme-preview.vim'
Plug 'guns/xterm-color-table.vim'

" {{{2 themes
Plug 'junegunn/seoul256.vim'
Plug 'jsit/toast.vim'
Plug 'vigoux/oak'
Plug 'zacanger/angr.vim'
Plug 'artanikin/vim-synthwave84'
Plug 'sainnhe/everforest'
Plug 'vim/colorschemes'

call plug#end()
" }}}

" {{{1 Colors
" {{{2 color settings
set termguicolors 									" enable 24bit
set background=dark									" dark mode

" {{{2 enable colorcolumn
if (exists('+colorcolumn'))
	set colorcolumn=80,100,120
endif

" {{{2 enable built-in language highlighting
let g:python_highlight_all = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:fortran_more_precise = 1
let g:fortran_free_source = 1
" {{{2 configure themes
let g:seoul256_background = 234
let g:airline_theme = 'simple'

" {{{2 experiments
func! TestColor()
	colorscheme desert
	:highlight ColorColumn guibg=Black ctermbg=0
	:highlight Folded guifg=DarkGray ctermbg=DarkGray
	:highlight NonText guibg=Gray23 ctermbg=237
	:highlight Normal guibg=Gray23 ctermbg=237
	:highlight Comment guifg=Gray39 ctermfg=241
	" :highlight Type guifg=Green4 ctermfg=28
	:highlight LineNr guifg=DarkGray
endfunc

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! SynReset()
	:syntax reset
	:syntax off
	:syntax on
endfun

" {{{2 turn on the colors
try
	colorscheme	angr
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme desert
endtry
" }}}

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
nnoremap <leader>ff :set guifont=Menlo-Regular:h12

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

" {{{1 PlantUML
let g:plantuml_set_makeprg = 0

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

" {{{1 ALE
inoremap <C-space> <C-X><C-O>
let g:ale_completion_enabled = 1
let g:ale_python_auto_pipenv = 1
let g:ale_python_pylsp_auto_pipenv = 1
let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_history_log_output = 1
let g:ale_history_enabled = 1
let g:ale_set_balloons = 1
let g:ale_completion_autoimport = 1
let g:ale_completion_delay = 1000
set omnifunc=ale#completion#OmniFunc
let g:ale_echo_msg_format='%linter%:%code: %%s'
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_detail_to_floating_preview = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_virtualtext_cursor = 'current'
let g:ale_max_signs = 100
let g:ale_linters = {
\	'cs': ['OmniSharp'],
\	'go': ['golangci-lint', 'gofmt', 'gobuild', 'gopls'],
\	'python': ['flake8', 'mypy', 'pylsp', 'pycodestyle', 'pydocstyle', 'pylint', 'ruff'],
\}
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'go': ['gofmt', 'goimports', 'gopls'],
\   'python': ['black', 'ruff', 'yapf'],
\}
let g:ale_disable_lsp = 0
let b:ale_disable_lsp = 0
let g:ale_fix_on_save = 1
let g:ale_lsp_suggestions = 1
let g:ale_go_golangci_lint_options = '--timeout 10m'
let g:ale_go_golangci_lint_package = 1
let g:ale_yaml_yamllint_options = ''

nnoremap <F12> :ALEGoToDefinition -split

" {{{1 OmniSharp
let g:OmniSharp_selector_ui = ''       " Use vim - command line, quickfix etc.
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 0
let g:OmniSharp_diagnostic_showid = 1
" CA1304 : The behavior of 'string.ToLower()' could vary based on the current user's locale settings.
" CA1305 : The behavior of 'string.Format(string, object)' could vary based on the current user's locale settings.
" CS1118 : Mark local variable as const
" IDE0010 : Populate switch
" IDE0011 : Add braces to 'if' statement
" IDE0058 : Expression value is never used
" RCS1124 : Inline local variable
" RCS1181 : Convert comment to documentation comment
" RCS1238 : Avoid nested ?: operators
" IDE0078 : Use pattern matching
let g:OmniSharp_diagnostic_overrides = {
\	'CA1304': {'type': 'None'},
\	'CA1305': {'type': 'None'},
\	'CS1118': {'type': 'None'},
\	'IDE0008': {'type': 'None'},
\	'IDE0010': {'type': 'None'},
\	'IDE0011': {'type': 'None'},
\	'IDE0058': {'type': 'None'},
\	'IDE0078': {'type': 'None'},
\	'RCS1124': {'type': 'None'},
\	'RCS1181': {'type': 'None'},
\	'RCS1238': {'type': 'None'},
\}

" {{{1 Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

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
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

" {{{2 g:fzf_action
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
\}

" {{{2 g:fzf_colors
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
