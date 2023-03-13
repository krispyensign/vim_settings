set nocompatible              " be iMproved, required
syntax on

set t_Co=256
set background=dark
set encoding=utf8
set t_ut=
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
set hidden
set backspace=indent,eol,start
set guioptions-=T
set guioptions-=e
set guioptions-=r
set guioptions-=L
set clipboard^=unnamed,unnamedplus
set ttyfast
set showmatch
set cmdheight=2
set noshowmode
set switchbuf+=usetab,newtab
set mouse=a
set ttymouse=sgr

colorscheme gruvbox             " set color scheme
filetype plugin indent on

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

" Per OS settings
if has('macunix')
  set guifont=SourceCodeProForPowerline-Bold:h14
  set rtp+=/usr/local/opt/fzf
  let g:slimv_swank_cmd = 
        \ '!start "/usr/local/bin/csi" -l "$HOME/.vim/pack/$USER/r7rs-swank/chicken-swank.sld"'

elseif has('unix')
  set guifont=Cousine\ for\ Powerline\ Bold\ 10
  set rtp+=~/.fzf
  let g:slimv_swank_cmd = 
        \ '!start "csi" -l "$HOME/.vim/pack/$USER/r7rs-swank/chicken-swank.sld"'

elseif has('win32')
  let &pythonthreedll = 'C:\python38\python38.dll'
  set guifont=Source_Code_Pro_for_Powerline:h10:b
  let g:slimv_swank_cmd = 
        \ '!start "csi.exe" -l "$HOME/vimfiles/pack/$USER/r7rs-swank/chicken-swank.sld"'

endif

" Set color column to light grey
if (exists('+colorcolumn'))
  set colorcolumn=100
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

" Highlight settings
let python_highlight_all = 1
let rust_highlight_all = 1
let cpp_highlight_all = 1
let typescript_highlight_all = 1
let javascript_highlight_all = 1

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

" Airline settings
let g:airline_theme = 'badwolf'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 0

" Tagbar settings
let g:tagbar_map_showproto = 'P'

" Scheme settings
let g:scheme_executable = "gsi"

" Language client settings
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')
let g:LanguageClient_serverCommands = {
    \ 'java': ['~/bin/java-lsp.sh'],
    \ 'python': ['pyls'],
    \ 'cpp': ['clangd'],
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'java': ['gradlew'],
    \ 'cpp': ['compile_commands.json'],
    \ }

