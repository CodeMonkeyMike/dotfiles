call plug#begin()
" Autoload plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
set rtp+=~/.fzf
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <C-x><c-l> <plug>(fzf-complete-line)

fun! s:fzf_root()
  let path = finddir(".git", expand("%:p:h").";")
  return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>

" Color schemes
Plug 'morhetz/gruvbox'

" Syntaxes and Language Specific tools
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'elzr/vim-json', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
call plug#end()

" To prevent issues with fish shell
set shell=/bin/zsh

" Force dark color scheme for gruvbox
set background=dark

" Colorscheme... duh
colorscheme gruvbox

" Turn off highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Toggle paste mode
set pastetoggle=<F11>

" Quick exit insert mode
inoremap jj <Esc>`^
inoremap JJ <Esc>`^

" Save as sudo
cnoremap w!! %!sudo tee > /dev/null %

" Silence the bells
set noerrorbells visualbell t_vb=
au GUIEnter * set visualbell t_vb=

" Highlight matching brace
set showmatch

" Gods gift to humanity, case insensitive search
set ignorecase

" Line number
set relativenumber
set number

" Show information of command which is currently being run
set showcmd

" Cursor will remain in same place it was left after changing buffers
set nostartofline

" Go to end of line will go to last character
set virtualedit=onemore

" Indent Settings
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Timeout settings
set notimeout ttimeout ttimeoutlen=200

" Command line height is two lines
set cmdheight=2

" Change vertical line to a solid pipe
set fillchars+=vert:│

" Make comments italic
highlight Comment cterm=italic

" @todo: put msg here
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

inoremap <C-U> <C-G>u<C-U>
