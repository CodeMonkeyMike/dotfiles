set encoding=utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
" Autoload plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{ fzf.vim config
set rtp+=~/.fzf

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <C-x><c-l> <plug>(fzf-complete-line)

function! s:fzf_root()
  let path = finddir(".git", expand("%:p:h").";")
  return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfunction

nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>
" }}}
Plug 'itchyny/lightline.vim'
" {{{ lightline.vim config
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename',
    \   'fileformat': 'LightLineFileformat',
    \   'filetype': 'LightLineFiletype',
    \   'fileencoding': 'LightLineFileencoding',
    \   'mode': 'LightLineMode',
    \   'ctrlpmark': 'CtrlPMark',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
" }}}
" {{{ deoplete.nvim pre hook
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
" }}}
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let deoplete#omni#input_patterns = {
  \ 'php': '\w+|[^. \t]->\w*\|\w+::\w*'
  \ }

" Define keyword
if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif

let g:deoplete#keyword_patterns.default = '[a-zA-Z_]\w{2,}?'
" }}}
Plug 'edkolev/tmuxline.vim'
" {{{ tmuxline.vim config
inoremap <C-U> <C-G>u<C-U>
let g:tmuxline_preset = {
    \'a'    : '#S',
    \'b'    : '#W',
    \'c'    : '#H',
    \'win'  : '#I #W',
    \'cwin' : '#I #W',
    \'x'    : '%a',
    \'y'    : '%R',
    \'z'    : '%e %b %g'}

let g:tmuxline_separators = {
    \ 'left'      : '',
    \ 'left_alt'  : '',
    \ 'right'     : '',
    \ 'right_alt' : '',
    \ 'space'     : ' '}
" }}}
Plug 'scrooloose/nerdtree'
" {{{ nerdtree config
map <Leader>ft :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" }}}
Plug 'Xuyuanp/nerdtree-git-plugin'
" {{{ nerdtree-git-plugin config
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" }}}
Plug 'neomake/neomake'
" {{{
let g:neomake_php_maker = ['php']
"let g:syntastic_javascript_checkers = ['eslint']
" }}}
Plug 'airblade/vim-gitgutter'
" {{{ vim-gitgutter config
let g:gitgutter_max_signs = 1000
let g:gitgutter_map_keys = 0
" }}}
Plug 'Konfekt/FastFold'
Plug 'fntlnz/atags.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" Color schemes
Plug 'morhetz/gruvbox'
" {{{ gruvbox config
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
" }}}

" Syntaxes and Language Specific tools
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'elzr/vim-json', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
" {{{ php.vim config
let php_folding = 1
let php_sql_heredoc = 0
let g:sql_type_default = 'postgresql'
let b:sql_type_override = 'postgresql'
let php_html_load = 0
" }}}
call plug#end()

" Specify shell to prevent issues with fish shell
set shell=/bin/bash

" Force dark color scheme for gruvbox
set background=dark

" Neovim 24bit color mode
set termguicolors

" Custom color scheme
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
set noerrorbells visualbell
au GUIEnter * set visualbell

" Highlight matching brace
set showmatch

" Prevent word wrap on long lines
set nowrap

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
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 foldmethod=syntax
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 foldmethod=marker
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=4 tabstop=4 foldmethod=syntax omnifunc=phpcomplete#CompletePHP
autocmd FileType fish setlocal shiftwidth=4 tabstop=4
"autocmd FileType gitcommit setlocal complete=.,kspell

" Timeout settings
set notimeout ttimeout ttimeoutlen=200

" Command line height is two lines was 2
set cmdheight=1

" Change vertical line to a solid pipe
set fillchars=vert:│,fold:┄

" Dont show what mode your in command bar
set noshowmode

" @todo: put msg here
" set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" For the spelling on text files
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" Deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:atags_build_commands_list = [
    \ 'ag --php -g "" | ctags -L - --fields=+l -f tags.tmp',
    \ 'awk "length($0) < 400" tags.tmp > tags',
    \ 'rm tags.tmp'
    \ ]

" Atags generate tags on buffer save
autocmd BufWritePost * call atags#generate()
