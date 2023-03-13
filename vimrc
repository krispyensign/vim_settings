" Settings {{{
set nocompatible					" be iMproved, required
syntax on							" enable syntax highlighting
set termguicolors 					" enable 24 bit
set background=dark 				" dark mode
set encoding=utf8 					" default encoding
set t_ut=							" use current background color
set nowrap							" no text wrap
set number							" turn on numbering
set foldenable						" turn on folding
set foldmethod=syntax				" make folds based per syntax
set foldlevel=2						" start with 2 folds open
set signcolumn=yes					" gutter enabled
set backspace=indent,eol,start		" enable backspace key
set guioptions=gm					" enable menu only
set clipboard^=unnamed,unnamedplus	" setup clipboard to be more integrated
set ttyfast							" speed things up with tty
set showmatch						" show matches on /
set cmdheight=2						" command line bar is 2 chars high
set noshowmode						" managed by airline instead
set switchbuf+=usetab,newtab		" default commands to start a new tab
set mouse=a							" enable mouse integrations for tty
set ttymouse=sgr					" more tty integrations for mouse
set cursorline						" enable visual line for for cursor
set updatetime=300					" improve latency
set tabstop=4						" make sure if tabs are used it displays 4 and not 8
set shiftwidth=4					" shifts should also display as 4
set ssop-=options					" do not store global and local values in a session
set ssop-=folds						" do not store folds
set hlsearch						" enable highlighting during search
set listchars=eol:⏎,tab:▸\ ,trail:␠,nbsp:⎵,space:.
" }}}

" Sessions {{{
au VimLeave * :call MakeSession()
if(argc() == 0)
	au VimEnter * nested :call LoadSession()
endif
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')
" general language plugins
Plug 'vim-syntastic/syntastic'
Plug 'ycm-core/YouCompleteMe', { 'do': ':term++shell ./install.py --all --verbose && chmod -R u+rw ./' }
Plug 'majutsushi/tagbar'
Plug 'puremourning/vimspector', { 'do': ':term++shell ./install_gadget.py --verbose --all && chmod -R u+rw ./' }
Plug 'vim-test/vim-test'

" language specific plugins
Plug 'aklt/plantuml-syntax'
Plug 'hashivim/vim-terraform'
Plug 'rust-lang/rust/vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/vim-markdown'

" navigation plugins
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" supplemental theme plugins
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'

" theme plugins
Plug 'rafalbromirski/vim-aurora'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
Plug 'srcery-colors/srcery-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'embark-theme/vim'
Plug 'erizocosmico/vim-firewatch'
Plug 'AlessandroYorba/Alduin'
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'sainnhe/everforest'
Plug 'kaicataldo/material.vim'
Plug 'connorholyday/vim-snazzy'
Plug 'jacoborus/tender'
Plug 'mhinz/vim-janah'
Plug 'AhmedAbdulrahman/vim-aylin'
Plug 'ghifarit53/tokyonight-vim'
call plug#end()
" }}}

" Colors {{{
" various theme settings
let g:alduin_Shout_Dragon_Aspect = 1
let g:everforest_background = 'hard'
let g:everforest_disable_italic_comment = 1
let g:material_theme_style = 'darker'
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1
let g:tokyonight_cursor = "red"

" set color column to light grey
if (exists('+colorcolumn'))
	set colorcolumn=100
	highlight ColorColumn ctermbg=9
endif

" turn on the colors
colorscheme everforest
let g:airline_theme = 'everforest'
" }}}

" Custom Shortcuts {{{
" Cheatsheet for randos
" C-w N terminal Normal mode
" * search for whole word under cursor
" # search for partial word under cursor
" TODO: add more cheatsheet things

" leader remap for ergonomic
let mapleader = ' '
" navigation maps
nnoremap <silent> <leader><Up> :wincmd k<CR>
nnoremap <silent> <leader><Down> :wincmd j<CR>
nnoremap <silent> <leader><Left> :wincmd h<CR>
nnoremap <silent> <leader><Right> :wincmd l<CR>
nnoremap <silent> <leader>[ :vertical resize +5<CR>
nnoremap <silent> <leader>] :vertical resize -5<CR>

" toggles
nnoremap <leader>c :cwindow5<CR>
nnoremap <leader>l :lwindow5<CR>
nnoremap <leader>s :call ToggleGstatus()<CR>
nnoremap <leader>n :15Lexplore<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>p :pclose<CR>
nnoremap <leader>h :helpclose<CR>
nnoremap <leader>m :call MakeSession()<CR>
nnoremap <leader>i :set invlist<CR>

" debug vimrc map
nnoremap <leader>RS :source %<CR>
nnoremap <leader>RR :source $MYVIMRC<CR>

" ycm
nnoremap <leader>yh <Plug>(YCMToggleInlayHints)
nnoremap <leader>yd <Plug>(YCMDiags)
nnoremap <leader>ys <Plug>(YCMToggleSignatureHelp)
nnoremap <leader>yq <plug>(YCMHover)
nnoremap <leader>yf :YcmCompleter Format<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>yt :YcmCompleter FixIt<CR>
nnoremap <leader>yc :YcmForceCompileAndDiagnostics<CR>
" }}}

" Language Settings {{{
filetype plugin indent on " allow filetype to be completely managed by vim
au FileType vim,txt setlocal foldmethod=marker
au FileType go setlocal makeprg=$HOME/go/bin/golangci-lint\ run\ --config\ $HOME/.golang-lint.yml
au BufWritePost *.go call GoFmt()

let python_highlight_all = 1
let rust_highlight_all = 1
let cpp_highlight_all = 1
let typescript_highlight_all = 1
let javascript_highlight_all = 1
let java_highlight_all = 1
" }}}

" NetRW {{{
let g:netrw_list_hide = '.*\.swp$,\.git/'
let g:netrw_hide = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_mousemaps = 0
" }}}

" Rainbow {{{
let g:rainbow_active = 1
" }}}

" Airline {{{
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 0
" }}}

" Tagbar {{{
let g:tagbar_map_showproto = 'P'
let g:tagbar_autoclose_netrw = 1
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = {
	\ "mode": "active",
	\ "active_filetypes": [],
	\ "passive_filetypes": ["rust", "python", "javascript", "go", "typescript", "java", "csharp"] }
" }}}

" YouCompleteMe {{{
let g:ycm_enable_semantic_highlighting = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
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

command! -bang -nargs=* Rggo
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type go -- ".shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgrs
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type rust -- ".shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgjs
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type javascript -- ".shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgts
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type typescript -- ".shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgjava
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type java -- ".shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgcs
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type csharp -- ".shellescape(<q-args>),
\		1, fzf#vim#with_preview(), <bang>0)
" }}}

" Custom Language Functions {{{
func! GoFmt()
	let saved_view = winsaveview()
	silent %!gofmt
	if v:shell_error > 0
		cexpr getline(1, '$')->map({ idx, val -> val->substitute('<standard input>', expand('%'), '') })
		silent undo
		cwindow
	endif
	call winrestview(saved_view)
endfunc
" }}}

" Toggle Functions {{{
func! ToggleGstatus() abort
	for l:winnr in range(1, winnr('$'))
		if !empty(getwinvar(l:winnr, 'fugitive_status'))
			exe l:winnr 'close'
			return
		endif
	endfor
	keepalt :abo Git
endfun
" }}}

" Sessions Functions {{{ 
func! CloseBufferByName(name)
	if (bufexists(a:name) && buflisted(a:name))
		let b:nr = bufnr(a:name)
		exe b:nr . 'bd'
	endif
endfunc

func! CloseGstatus() abort
	for l:winnr in range(1, winnr('$'))
		if !empty(getwinvar(l:winnr, 'fugitive_status'))
			exe l:winnr 'close'
			return
		endif
	endfor
endfunc

func! MakeSession()
	call CloseBufferByName('NetrwTreeListing')
	tabdo call CloseGstatus()
	tabdo TagbarClose
	tabdo pclose | lclose | cclose | helpclose
	" TODO: figure out how to keep these all open correctly
	let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
	if (filewritable(b:sessiondir) != 2)
		exe 'silent !mkdir -p ' b:sessiondir
		redraw!
	endif
	let b:filename = b:sessiondir . '/session.vim'
	exe "mksession! " . b:filename
endfunc

func! LoadSession()
	let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
	let b:sessionfile = b:sessiondir . "/session.vim"
	if (filereadable(b:sessionfile))
		exe 'source ' b:sessionfile
		redraw!
	" TODO: change tagbar to open below netrw ??
	else
		echo "No session loaded."
	endif
endfunc
" }}}

