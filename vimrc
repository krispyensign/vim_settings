set nocompatible                    " be iMproved, required
syntax on                           " enable syntax highlighting

set t_Co=256                        " enable 256 colors
set background=dark                 " dark mode
set encoding=utf8                   " default encoding
set t_ut=                           " use current background color
set nowrap                          " no text wrap
set number                          " turn on numbering
set foldenable                      " turn on folding
set foldmethod=syntax               " make folds based per syntax
set foldlevel=2                     " start with 1 fold open
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

silent! helptags ALL                " load all help tags after everything else
filetype plugin indent on           " allow filetype to be completely managed by vim

" colors
colorscheme badwolf

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
nnoremap <silent> <leader>T :bel term<CR>
nnoremap <silent> <leader>l :lopen<CR>

" YCM leader mappings
nnoremap <silent> <leader>h <Plug>(YCMToggleInlayHints)
nnoremap <silent> <leader>d <Plug>(YCMDiags)
nnoremap <silent> <leader>s <Plug>(YCMToggleSignatureHelp)

" Rg search commands
command! -bang -nargs=* Rggo
\	call fzf#vim#grep(
\		"rg --column --line-number --no-heading --color=always --smart-case --type *.go -- ".shellescape(<q-args>),
\		1, 
\		fzf#vim#with_preview(),
\ 		<bang>0)

" Per OS settings
if has('macunix')
  set guifont=SourceCodeProForPowerline-Bold:h14
  set rtp+=/usr/local/opt/fzf

elseif has('unix')
  set guifont=Cousine\ for\ Powerline\ Bold\ 10
  set rtp+=~/.fzf

elseif has('win32')
  let &pythonthreedll = 'C:\python38\python38.dll'
  set guifont=Source_Code_Pro_for_Powerline:h10:b
  set shell='C:/Program\ Files/Git/bin/bash.exe'

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

" YCM settings
let g:ycm_enable_semantic_highlighting=1

" Syntastic settings
" disable checkers that YCM handles
let g:syntastic_python_checkers = []
let g:syntastic_rust_checkers = []
let g:syntastic_javascript_checkers = []
let g:syntastic_go_checkers = []
let g:syntastic_typescript_checkers = []

" Syntastic settings for all other files that don't have LSPs installed yet
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

