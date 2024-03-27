" Top Level Settings {{{
set nocompatible									" be iMproved, required
syntax on											" enable syntax highlighting
set encoding=utf8									" default encoding
set nowrap											" no text wrap
set number											" turn on numbering
set foldenable										" turn on folding
set foldmethod=indent								" make folds based per syntax
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
set completeopt=menuone,popup
" }}}

" General Language Settings {{{
au FileType vim,txt setlocal foldmethod=marker
" }}}

" Plugins {{{
command! PU PlugUpdate | PlugUpgrade
filetype plugin indent on " allow filetype to be completely managed by vim

call plug#begin('~/.vim/plugged')

" general language plugins
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'ycm-core/YouCompleteMe'
Plug 'puremourning/vimspector'

" language specific plugins
Plug 'hashivim/vim-terraform', { 'for' : 'terraform' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'preservim/vim-markdown', { 'for' : ['markdown', 'vim-plug'] }
Plug 'vito-c/jq.vim', { 'for' : 'jq' }
Plug 'aklt/plantuml-syntax'
Plug 'jackielii/vim-gomod', { 'for' : ['gomod', 'gosum'] }
Plug 'OmniSharp/omnisharp-vim', { 'for' : 'cs' }

" navigation plugins
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'krispyensign/sesssion.vim'

" git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" supplemental theme plugins
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()
" }}}

" Colors {{{
set background=dark					" dark mode
set termguicolors					" enable 24 bit
set t_ut=							" use current background color

" enable built-in language highlighting
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

" turn on the colors
colorscheme retrobox
hi Normal ctermbg=16 guibg=#000000
" }}}

" set color column to light grey
if (exists('+colorcolumn'))
	set colorcolumn=80,100,120
	highlight ColorColumn ctermbg=9
endif

" Custom Shortcuts {{{
" Cheatsheet for randos
" C-w N terminal Normal mode
" C-w x switch files during diff this
" C-w r rotate files
" C-] jump to tag in ctags or follow link in help file
" C-o jump back
" C-x C-o omnifunc
" C-x C-u completefunc
" 1gd jump to local var
" * search for whole word under cursor
" # search for partial word under cursor

" leader remap for ergonomic
let mapleader = ' '

" navigation maps
nnoremap <silent> <leader><Up> :wincmd k<CR>
nnoremap <silent> <leader><Down> :wincmd j<CR>
nnoremap <silent> <leader><Left> :wincmd h<CR>
nnoremap <silent> <leader><Right> :wincmd l<CR>
nnoremap <silent> <leader>[ :vertical resize +5<CR>
nnoremap <silent> <leader>] :vertical resize -5<CR>
nnoremap <silent> <leader>* :nohls<CR>

" toggles
nnoremap <leader>s :call ToggleGstatus()<CR>
nnoremap <leader>n :15Lexplore<CR>
nnoremap <leader>p :pclose<CR>
nnoremap <leader>h :helpclose<CR>
nnoremap <leader>i :set invlist<CR>

" debug vimrc map
nnoremap <leader>RS :source %<CR>
nnoremap <leader>RR :source $MYVIMRC<CR>

" ycm
nnoremap <leader>yy <Plug>(YCMDiags)
nnoremap <leader>ys <Plug>(YCMToggleSignatureHelp)
nnoremap <leader>yh <Plug>(YCMHover)
nnoremap <leader>yd :YcmCompleter GetDoc<CR>
nnoremap <leader>yf :YcmCompleter Format<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>yR yiw :YcmCompleter RefactorRename <C-R>"
nnoremap <leader>yt :YcmCompleter FixIt<CR>
nnoremap <leader>yc :YcmForceCompileAndDiagnostics<CR>

" tags
nnoremap <leader>tt :TagbarToggle<CR>

" git
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
" }}}

" PlantUML {{{
let g:plantuml_set_makeprg = 0
" }}}

" Rainbow {{{
let g:rainbow_active = 1
" }}}

" Airline {{{
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#format = 1

let g:airline#extensions#fugitiveline#enabled = 1

let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'

let g:airline_powerline_fonts = 0
let g:airline_experimental = 1
let g:airline_highlighting_cache = 1
let g:airline_extensions = ['tabline', 'branch', 'fugitiveline', 'fzf',
\	'tagbar', 'virtualenv', 'whitespace', 'term', 'ale', 'ycm']
" }}}

" Tagbar {{{
let g:tagbar_autoclose_netrw = 1
" }}}

" Netrw {{{
let g:netrw_list_hide = '.*\.swp$,\.git/'
let g:netrw_hide = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_mousemaps = 0
" }}}

" ALE {{{
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_virtualtext_cursor = 'current'
let g:ale_max_signs = 100
let g:ale_linters = {
\	'cs': ['OmniSharp'],
\}
" }}}

" YouCompleteMe {{{
let g:ycm_open_loclist_on_ycm_diags = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_min_num_of_chars_for_completion = 5
let g:ycm_filetype_specific_completion_to_disable = {
\	'cs': 1,
\	'csharp': 1}
" }}}

" OmniSharp {{{
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
" }}}

" Vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" FZF {{{
let g:fzf_action = {
\	'ctrl-t': 'tab split',
\	'ctrl-x': 'split',
\	'ctrl-v': 'vsplit',
\	'ctrl-q': 'fill_quickfix'}
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

command! -bang -nargs=* Rgl
\	call fzf#vim#grep(
\		'rg --column --line-number --no-heading --color=always --smart-case --type ' ..
\			&filetype ..
\			' -- ' ..
\			shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgg
\	call fzf#vim#grep(
\		'rg --column --line-number --no-heading --color=always --smart-case --glob \\*.' ..
\			expand('%:e') ..
\			' -- ' ..
\			shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)
" }}}

