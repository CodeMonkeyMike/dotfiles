call plug#begin()
" Autoload plugins
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/syntastic', { 'for': ['javascript', 'shell', 'php', 'fish'] }
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
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

" Allow Airline to use special symbols
let g:airline_powerline_fonts=1

" Tmuxline configuration
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '#W %R',
      \'z'    : '#H'}

" Force dark color scheme for gruvbox
set background=dark

" Colorscheme... duh
colorscheme gruvbox

" Syntastic Statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic checkers
let g:syntastic_php_checkers=['php']
let g:syntastic_javascript_checkers=['eslint']

" Syntastic Settings
let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Turn off highlighting
nnoremap <C-L> :nohl<CR><C-L>

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

" Highlight search results
set hlsearch

" Incremental searching, aka search as typed
set incsearch

" Highlight matching brace
set showmatch

" Gods gift to humanity, case insensitive search
set ignorecase

" Line number
set relativenumber

" Status line always on
set laststatus=2

" Command line completion
set wildmenu

" Show information of command which is currently being run
set showcmd

" Cursor will remain in same place it was left after changing buffers
set nostartofline

" Go to end of line will go to last character
set virtualedit=onemore

" Indent Settings
set backspace=indent,eol,start
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Timeout settings
set notimeout ttimeout ttimeoutlen=200

" Command line height is two lines
set cmdheight=2

" PHP syntax settings
let php_html_in_heredoc=0
let php_html_load=0
let php_sql_heredoc=0
let g:sql_type_default='postgresql'
let php_ignore_phpdoc=1

" Change vertical line to a solid pipe
set fillchars+=vert:│

" For Fuzzy File Finder
set rtp+=/usr/local/opt/fzf

" Make comments italic
highlight Comment cterm=italic

" Map key to a syntax finding token function
"map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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
