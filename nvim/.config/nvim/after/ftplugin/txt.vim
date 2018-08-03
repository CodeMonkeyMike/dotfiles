scriptencoding utf-8

setlocal wrap linebreak nolist spell spelllang=en_us

" We don't have a notion of comments in plain text.
" This also un-fucks the use of '*' in formatlistpat.
setlocal comments=
" Use comment string for quoting
setlocal commentstring=>\ %s

" {{{ txt files extra option
" function! PlainText()
"   " We don't have a notion of comments in plain text.
"   " This also un-fucks the use of '*' in formatlistpat.
"   setlocal comments=
"   " Use comment string for quoting
"   setlocal commentstring=>\ %s
"   setlocal spell
" endfunction

" autocmd FileType txt call PlainText()
" }}}
