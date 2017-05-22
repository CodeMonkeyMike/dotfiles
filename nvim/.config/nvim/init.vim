set encoding=utf-8
scriptencoding utf-8

set shell=/bin/bash

set runtimepath+=/home/mike/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/mike/.local/share/dein')
  call dein#begin('/home/mike/.local/share/dein')

  " Let dein manage dein
  " After adding call:
  "     call dein#install()
  call dein#add('/home/mike/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Colorschemes:
  call dein#add('morhetz/gruvbox')
  call dein#add('mhartington/oceanic-next')

  call dein#add('StanAngeloff/php.vim', {'on_ft': 'php'})
  call dein#add('JulesWang/css.vim', {'on_ft': 'css'})
  call dein#add('dag/vim-fish', {'on_ft': 'fish'})
  call dein#add('guns/vim-clojure-static', {'on_ft': 'clojure'})
  call dein#add('keith/tmux.vim', {'on_ft': 'tmux'})
  call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
  call dein#add('exu/pgsql.vim', {'on_ft': 'pgsql'})
  call dein#add('jrk/vim-ocaml', {'on_ft': 'ocaml'})
  call dein#add('tbastos/vim-lua', {'on_ft': 'lua'})
  call dein#add('elzr/vim-json', {'on_ft': 'json'})
  call dein#add('othree/html5.vim', {'on_ft': 'html'})
  call dein#add('lambdatoast/elm.vim', {'on_ft': 'elm'})
  call dein#add('elixir-lang/vim-elixir', {'on_ft': 'elixir'})
  call dein#add('mxw/vim-jsx', {'on_ft': 'javascript'})
  call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript'})

  call dein#add('luochen1990/rainbow', {'on_ft': ['clojure', 'json']})

  call dein#add('neomake/neomake')
  call dein#add('itchyny/lightline.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Konfekt/FastFold')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-repeat')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox
set background=dark

set backspace=indent,eol,start
set complete-=i
set nrformats-=octal
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set viminfo^=!
set sessionoptions-=options
set formatoptions+=j
set showmatch
set ignorecase
set wildignorecase
set showcmd
set notimeout ttimeout ttimeoutlen=200
set noshowmode
set nostartofline
set termguicolors " 24-bit color

setglobal tags-=./tags tags-=./tags; tags^=./tags;

inoremap <C-U> <C-G>u<C-U>

" Turn off highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Prevent word wrap on long lines
set nowrap

" Line number
set relativenumber
set number

" Go to end of line will go to last character
set virtualedit=onemore

" Default Indent Settings
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent

" Change vertical line to a solid pipe
set fillchars=vert:│,fold:┄

" Save write only file
cnoremap w!! %!sudo tee > /dev/null %

" set wildignore+=\*/node_modules/\*

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" {{{ neomake/neomake config
augroup makers
  autocmd!
augroup END
autocmd makers BufWritePost * Neomake
" }}}

" {{{ luochen1990/rainbow 'colored parens' config
augroup coloredParens
  autocmd!
augroup END
autocmd coloredParens FileType clojure,json call rainbow#toggle()
" }}}

" {{{ tpope/vim-fugitive config
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
" }}}

" {{{ Konfekt/FastFold config
let g:php_folding=1
" }}}

" {{{ mxw/vim-jsx config
let g:jsx_ext_required=0
" }}}

" {{{ StanAngeloff/php.vim config
let g:php_sql_heredoc=0
let g:sql_type_default='postgresql'
let b:sql_type_override='postgresql'
let g:php_html_load=0
" }}}

" {{{ morhetz/gruvbox config
let g:gruvbox_italic=1
" }}}

" {{{ itchyny/lightline.vim config
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }
" }}}

" {{{ airblade/vim-gitgutter config
let g:gitgutter_max_signs=1000
let g:gitgutter_map_keys=0
let g:gitgutter_realtime=0
" }}}

" {{{ junegunn/fzf.vim config
set runtimepath+=~/.fzf

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <C-x><c-l> <plug>(fzf-complete-line)

function! s:fzf_root()
  let l:path = finddir('.git', expand('%:p:h').';')
  return fnamemodify(substitute(l:path, '.git', '', ''), ':p:h')
endfunction

nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>
" }}}

