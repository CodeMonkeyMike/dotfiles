" To prevent issues with fish shell
set shell=/bin/bash

" Good default colorscheme
colorscheme ron

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

" @todo: put msg here
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

inoremap <C-U> <C-G>u<C-U>
