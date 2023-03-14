" Settings {{{
set nocompatible					" be iMproved, required
syntax on							" enable syntax highlighting
set termguicolors					" enable 24 bit
set background=dark					" dark mode
set encoding=utf8					" default encoding
set t_ut=							" use current background color
set nowrap							" no text wrap
set number							" turn on numbering
set foldenable						" turn on folding
set foldmethod=indent				" make folds based per syntax
set signcolumn=yes					" gutter enabled
set backspace=indent,eol,start		" enable backspace key
set guioptions=gm					" enable menu only
set clipboard^=unnamed,unnamedplus	" setup clipboard to be more integrated
set ttyfast							" speed things up with tty
set cmdheight=2						" command line bar is 2 chars high
set noshowmode						" managed by airline instead
set noshowmatch						" do not try to jump to braces
set switchbuf+=usetab,newtab		" default commands to start a new tab
set mouse=a							" enable mouse integrations for tty
set ttymouse=sgr					" more tty integrations for mouse
set cursorline						" enable visual line for for cursor
set tabstop=4						" make sure if tabs are used it displays 4 and not 8
set shiftwidth=4					" shifts should also display as 4
set ssop-=options					" do not store global and local values in a session
set ssop-=folds						" do not store folds
set hlsearch						" enable highlighting during search
set listchars=eol:⏎,tab:▸\ ,trail:␠,nbsp:⎵,space:.
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')
" general language plugins
Plug 'vim-syntastic/syntastic'
Plug 'ycm-core/YouCompleteMe', { 'do': ':term++shell TERM=xterm ./install.py --all --verbose && chmod -R u+rw ./' }
Plug 'majutsushi/tagbar'
Plug 'puremourning/vimspector', { 'do': ':term++shell ./install_gadget.py --verbose --all --enable-go && chmod -R u+rw ./' }
Plug 'vim-test/vim-test'

" language specific plugins
Plug 'hashivim/vim-terraform', { 'for' : 'terraform' }
Plug 'rust-lang/rust/vim', { 'for' : 'rust' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/vim-markdown', { 'for' : ['markdown', 'vim-plug'] }
Plug 'johejo/gomod.vim', { 'for' : 'gomod' }

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
Plug 'ntpeters/vim-better-whitespace'

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
Plug 'jacoborus/tender.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jonathanfilip/vim-lucius'
Plug 'glepnir/oceanic-material'
call plug#end()
" }}}

" Sessions {{{
func! CloseBufferByName(name)
	if bufexists(a:name)
		let b:nr = bufnr(a:name)
		exe 'bd ' .. b:nr
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
	tabdo call CloseBufferByName('NetrwTreeListing')
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
	else
		echo "No session loaded from " .. b:sessionfile
	endif
endfunc

au VimLeave * :call MakeSession()
au VimEnter * nested :call LoadSession()
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
let macvim_skip_colorscheme = 1 " fix for tender.vim

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
nnoremap <silent> <leader>* :nohls<CR>

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

" General Language Settings {{{
filetype plugin indent on " allow filetype to be completely managed by vim
au FileType vim,txt setlocal foldmethod=marker
command! PU PlugUpdate | PlugUpgrade

let python_highlight_all = 1
let rust_highlight_all = 1
let cpp_highlight_all = 1
let typescript_highlight_all = 1
let javascript_highlight_all = 1
let java_highlight_all = 1
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
let g:airline_experimental = 1
let g:airline_highlighting_cache = 1
let g:airline_extensions = []
" }}}

" Tagbar {{{
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
	\ "passive_filetypes": ["rust", "python", "javascript", "go", "typescript", "java", "csharp", "cs"] }
" }}}

" Netrw {{{
let g:netrw_list_hide = '.*\.swp$,\.git/'
let g:netrw_hide = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_mousemaps = 0
" }}}

" YouCompleteMe {{{
let g:ycm_enable_semantic_highlighting = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_min_num_of_chars_for_completion = 5
<<<<<<< HEAD
" if has('win32') || has ('win64')
"     let g:ycm_roslyn_binary_path = $VIM."/vimfiles/contrib/omnisharp"
" else
"     let g:ycm_roslyn_binary_path = $HOME."/.vim/contrib/omnisharp"
" endif
=======
>>>>>>> be1d3e42bb801716e328becf6e895f240b77fc80
" }}}

" Vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" FZF {{{
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-x': 'split',
	\ 'ctrl-v': 'vsplit',
	\ 'ctrl-q': 'fill_quickfix'}
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

command! -bang -nargs=* Rgl
	\ call fzf#vim#grep(
	\	"rg --column --line-number --no-heading --color=always --smart-case --type " .. &filetype .." -- " .. shellescape(<q-args>),
	\	1, fzf#vim#with_preview(), <bang>0)
" }}}

