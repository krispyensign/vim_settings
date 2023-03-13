set nocompatible              " be iMproved, required

syntax on

set encoding=utf8
set t_ut=
set t_Co=256
set background=dark
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set number
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set signcolumn=yes
set ttyfast
set showmatch
set cmdheight=2
set hidden
set guioptions-=T
set noshowmode
set switchbuf+=usetab,newtab
set guifont=SourceCodeProForPowerline-Bold:h14

colorscheme gruvbox              " set color scheme

filetype plugin indent on

autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T

" Set color column to light grey
if (exists('+colorcolumn'))
  set colorcolumn=120
  highlight ColorColumn ctermbg=9
endif

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
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

" Rust racer settings
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" Echodoc settings
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = "virtual"

" Highlight settings
let java_highlight_all = 1
let java_highlight_functions = 1

" FZF settings
set rtp+=/usr/local/opt/fzf

" Enable virtual environments for python 3
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    with open(activate_this) as f:
        exec(f.read(), {'__file__': activate_this})
EOF

" Rainbow settings
let g:rainbow_active = 1
let g:rainbow_conf = { 'ctermfgs': [27, 142, 'magenta', 'cyan'] }

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Deoplete configurations
let g:deoplete#enable_at_startup = 1

" Tagbar settings
let g:tagbar_map_showproto = 'P'

" Language client settings
let g:LanguageClient_serverCommands = {
    \ 'java': ['~/bin/java-lsp.sh']
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_rootMarkers = {
    \ 'java': ['gradlew'],
    \ }

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:loaded_syntastic_java_javac_checker = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_cpp_checkers = [' ']
let g:syntastic_java_checkers = [' ']
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" My leader mappings
let mapleader = ' '
nnoremap <silent> <leader><Up> :wincmd k<CR>
nnoremap <silent> <leader><Down> :wincmd j<CR>
nnoremap <silent> <leader><Left> :wincmd h<CR>
nnoremap <silent> <leader><Right> :wincmd l<CR>
nnoremap <silent> <leader>[ :vertical resize +5<CR>
nnoremap <silent> <leader>] :vertical resize -5<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>c :cope<CR>
