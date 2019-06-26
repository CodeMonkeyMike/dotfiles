"==============================================================================
" FILE: init.vim
" Author: Mike Zipf
"==============================================================================
set encoding=utf-8
scriptencoding utf-8

" set shell=/bin/bash
set shell=/usr/local/bin/bash

set runtimepath+=/Users/mikezipf/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/mikezipf/.local/share/dein')
  call dein#begin('/Users/mikezipf/.local/share/dein')

  " Required:
  call dein#add('/Users/mikezipf/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Colorschemes:
  call dein#add('morhetz/gruvbox')

  " Language files
  call dein#add('dag/vim-fish', {'on_ft': 'fish'})
  call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
  call dein#add('elzr/vim-json', {'on_ft': 'json'})
  call dein#add('vim-scripts/txt.vim', {'on_ft': 'txt'})
  call dein#add('hdima/python-syntax', {'on_ft': 'python'})
  call dein#add('fatih/vim-go', {'on_ft': 'go'})

  " Language specific tools
  call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})

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

set scrolloff=1
set sidescrolloff=5
set viminfo^=!
set showmatch
set ignorecase
set wildignorecase
set notimeout
set ttimeoutlen=200
set noshowmode
set nostartofline
set fileencodings=utf-8,gb18030
set nowrap " Prevent word wrap on long lines
set relativenumber " Line number
set number
set virtualedit=onemore " Go to end of line will go to last character
set shiftwidth=4 " Default Indent Settings
set tabstop=4
set expandtab
set fillchars=vert:│,fold:┈,diff:┈ " Change vertical line to a solid pipe
" set termguicolors " 24-bit color

setglobal tags-=./tags tags-=./tags; tags^=./tags;

inoremap <C-U> <C-G>u<C-U>

" Dont open help menu with f1
nnoremap <F1> <nop>
inoremap <F1> <nop>

" Prevent me from closing all my splits, like a mo-ron
nnoremap <C-W>o <nop>
nnoremap <C-W><C-O> <nop>

" Easy vim split movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Turn off highlighting of :set hlsearch
nnoremap <leader>th :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Save write only file
cnoremap w!! %!sudo tee > /dev/null %

" set wildignore+=\*/node_modules/\*

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Open tag in split
nnoremap <leader>avt :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <leader>at :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Terminal should have no numbers
autocmd TermOpen * setlocal nonumber norelativenumber
" Spell check text
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell spelllang=en_us

nnoremap <leader>ts :set spell!<cr>
" TODO: add more spelling mappings

" {{{ Zoom / Restore window function
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
" }}}

" {{{ fatih/vim-go config
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" }}}

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
autocmd coloredParens FileType clojure call rainbow#toggle()
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
" set runtimepath+=~/.fzf

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
nnoremap <silent> <Leader>fw :Windows<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
" }}}

" {{{ scrooloose/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
nnoremap <silent> <Leader>tf :NERDTreeToggle<CR>
" }}}

" {{{ majutsushi/tagbar
nnoremap <silent> <Leader>tt :TagbarToggle<CR>
" }}}

" {{{ Shougo/Deoplete
set completeopt-=preview
let g:deoplete#enable_at_startup=1
let g:deoplete#sources={}
" }}}

" {{{ morhetz/gruvbox Post colorscheme config
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
" }}}
