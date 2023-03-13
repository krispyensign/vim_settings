" Settings {{{
set nocompatible                    " be iMproved, required
syntax on                           " enable syntax highlighting
set termguicolors
set background=dark                 " dark mode
set encoding=utf8                   " default encoding
set t_ut=                           " use current background color
set nowrap                          " no text wrap
set number                          " turn on numbering
set foldenable                      " turn on folding
set foldmethod=syntax               " make folds based per syntax
set foldlevel=2                     " start with 2 folds open
set signcolumn=yes                  " gutter enabled
set backspace=indent,eol,start      " enable backspace key
set guioptions=gm                   " enable menu only
set clipboard^=unnamed,unnamedplus  " setup clipboard to be more integrated
set ttyfast                         " speed things up with tty
set showmatch                       " show matches on /
set cmdheight=2                     " command line bar is 2 chars high
set noshowmode                      " managed by airline instead
set switchbuf+=usetab,newtab        " default commands to start a new tab
set mouse=a                         " enable mouse integrations for tty
set ttymouse=sgr                    " more tty integrations for mouse
set cursorline                      " enable visual line for for cursor
set updatetime=300                  " improve latency
set tabstop=4                       " make sure if tabs are used it displays 4 and not 8
set shiftwidth=4                    " shifts should also display as 4
filetype plugin indent on           " allow filetype to be completely managed by vim
autocmd FileType vim,txt setlocal foldmethod=marker
" }}}

" Plugins {{{
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !git submodule update --init --recursive && ./install.py --all --verbose
  endif
endfunction

call plug#begin('~/.vim/plugged')
" language plugins
Plug 'vim-syntastic/syntastic'
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'majutsushi/tagbar'
Plug 'hashivim/vim-terraform'
Plug 'krispyensign/vimux-golang'
Plug 'puremourning/vimspector'

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
Plug 'Everblush/everblush.vim'
Plug 'embark-theme/vim'
Plug 'juanedi/predawn.vim'
Plug 'erizocosmico/vim-firewatch'
Plug 'AlessandroYorba/Alduin'
Plug 'atelierbram/vim-colors_atelier-schemes' 
Plug 'sainnhe/everforest'
Plug 'connorholyday/vim-snazzy'
Plug 'hzchirs/vim-material'
Plug 'jacoborus/tender'
Plug 'mhinz/vim-janah'
Plug 'AhmedAbdulrahman/vim-aylin'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ghifarit53/tokyonight-vim'
call plug#end()
" }}}

" Colors {{{
colorscheme badwolf
let g:airline_theme = 'badwolf'

" set color column to light grey
if (exists('+colorcolumn'))
  set colorcolumn=100
  highlight ColorColumn ctermbg=9
endif
" }}}

" Custom Shortcuts {{{
" leader remap for ergonomic
let mapleader = ' '
" navigation maps
nnoremap <silent> <leader><Up> :wincmd k<CR>
nnoremap <silent> <leader><Down> :wincmd j<CR>
nnoremap <silent> <leader><Left> :wincmd h<CR>
nnoremap <silent> <leader><Right> :wincmd l<CR>
nnoremap <silent> <leader>[ :vertical resize +5<CR>
nnoremap <silent> <leader>] :vertical resize -5<CR>
nnoremap <silent> <leader>l :lopen<CR>
nnoremap <silent> <leader>co :cope<CR>
nnoremap <silent> <leader>pc :pclose<CR>
nnoremap <silent> <leader>f @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" debug vimrc map
nnoremap <silent> <leader>RS :source %<CR>
nnoremap <silent> <leader>RR :source $MYVIMRC<CR>
" custom function map
nnoremap <silent> <leader>z :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
nnoremap <silent> <leader>g :call ToggleGstatus()<CR>
" netwr
nnoremap <silent> <leader>n :100wincmd h<CR>:15Lexplore<CR>
" tagbar
nnoremap <silent> <leader>t <Plug>(TagbarToggle)
" ycm
nnoremap <silent> <leader>yh <Plug>(YCMToggleInlayHints)
nnoremap <silent> <leader>yd <Plug>(YCMDiags)
nnoremap <silent> <leader>ys <Plug>(YCMToggleSignatureHelp)
nnoremap <silent> <leader>yf :YcmCompleter Format<CR>
nnoremap <silent> <leader>yg :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>yx :YcmCompleter FixIt<CR>
"fugitive
nnoremap <silent> <leader>gh :G! push<CR>
nnoremap <silent> <leader>gl :G! pull<CR>
" }}}

" Standard Language Settings {{{
let python_highlight_all = 1
let rust_highlight_all = 1
let cpp_highlight_all = 1
let typescript_highlight_all = 1
let javascript_highlight_all = 1
let java_highlight_all = 1
" }}}

" NetRW {{{
autocmd TabNew * call feedkeys(":15Lexplore\<CR>", 'n')
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_mousemaps= 0
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
" }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
" }}}

" YouCompleteMe {{{
let g:ycm_enable_semantic_highlighting = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
let g:syntastic_python_checkers = []
let g:syntastic_rust_checkers = []
let g:syntastic_javascript_checkers = []
let g:syntastic_go_checkers = []
let g:syntastic_typescript_checkers = []
let g:syntastic_java_checkers = []
let g:syntastic_csharp_checkers = []
" }}}

" Vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" FZF Rg search commands {{{
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

" Custom Functions {{{
" highlight all instances of word under cursor, when idle. useful when studying strange source code.
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction

" fugitive
nnoremap gs :call ToggleGstatus()<CR>
function! ToggleGstatus() abort
  for l:winnr in range(1, winnr('$'))
    if !empty(getwinvar(l:winnr, 'fugitive_status'))
      exe l:winnr 'close'
      return
    endif
  endfor
  keepalt :abo Git
endfunction

" enable virtual environments for python 3
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    with open(activate_this) as f:
        exec(f.read(), {'__file__': activate_this})
EOF

" stream shell to preview
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'topleft new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
" }}}
