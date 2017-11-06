"==============================================================================
" FILE: init.vim
" Author: Mike Zipf <git@mikezipf.com>
"==============================================================================
set encoding=utf-8
scriptencoding utf-8

set shell=/bin/bash

set runtimepath+=/Users/mikez/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/mikez/.local/share/dein')
  call dein#begin('/Users/mikez/.local/share/dein')

  " Required:
  call dein#add('/Users/mikez/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Colorschemes:
  call dein#add('morhetz/gruvbox')
  call dein#add('mhartington/oceanic-next')

  " Language files
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

  " Language specific tools
  call dein#add('luochen1990/rainbow', {'on_ft': ['clojure', 'json']})
  call dein#add('padawan-php/deoplete-padawan', {'on_ft': 'php'})
  call dein#add('mkusher/padawan.vim', {'on_ft': 'php'})

  " Global tools
  call dein#add('neomake/neomake')
  call dein#add('itchyny/lightline.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Konfekt/FastFold')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-repeat')
  call dein#add('ludovicchabant/vim-gutentags')
  call dein#add('majutsushi/tagbar')
  call dein#add('scrooloose/nerdtree')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" {{{ morhetz/gruvbox Pre colorscheme config
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_italic=1
" }}}

colorscheme gruvbox
set background=dark

set backspace=indent,eol,start
set complete-=i
set nrformats-=octal
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:,precedes:,nbsp:◇
set viminfo^=!
set sessionoptions-=options
set formatoptions+=j
set showmatch
set ignorecase
set wildignorecase
set notimeout
set ttimeoutlen=200
set noshowmode
set nostartofline
set termguicolors " 24-bit color

setglobal tags-=./tags tags-=./tags; tags^=./tags;
inoremap <C-U> <C-G>u<C-U>

" Turn off highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>


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

" Change vertical line to a solid pipe
set fillchars=vert:│,fold:┈,diff:┈

" Save write only file
cnoremap w!! %!sudo tee > /dev/null %

" set wildignore+=\*/node_modules/\*

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Dont open help menu with f1
nnoremap <F1> <nop>
inoremap <F1> <nop>

" {{{ neomake/neomake config
augroup makers
  autocmd!
augroup END
autocmd makers BufWritePost * Neomake
let g:neomake_phpstan_level=4
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
nnoremap <silent> <Leader>ft :Ag<CR>
nnoremap <silent> <Leader>fc :BCommits<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fl :Lines<CR>
" }}}

" {{{ scrooloose/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
nnoremap <silent> <Leader>of :NERDTreeToggle<CR>
" }}}

" {{{ majutsushi/tagbar
nnoremap <silent> <Leader>ot :TagbarToggle<CR>
" }}}

" {{{ Shougo/Deoplete
set completeopt-=preview
let g:deoplete#enable_at_startup=1
let g:deoplete#sources={}
let g:deoplete#sources.php=['buffer', 'padawan']
" }}}

" {{{ padawan-php/deoplete-padawan
command! PadawanStart call deoplete#sources#padawan#StartServer()
command! PadawanStop call deoplete#sources#padawan#StopServer()
command! PadawanRestart call deoplete#sources#padawan#RestartServer()
command! PadawanInstall call deoplete#sources#padawan#InstallServer()
command! PadawanUpdate call deoplete#sources#padawan#UpdatePadawan()
command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)
" }}}

" {{{ morhetz/gruvbox Post colorscheme config
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
" }}}

