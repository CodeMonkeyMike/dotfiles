syn keyword phpFunctions array_add array_collapse array_divide array_dot array_except array_first array_flatten array_forget array_get array_has array_only array_pluck array_pull array_set array_sort array_sort_recursive array_where head last
syn keyword phpFunctions app_path base_path config_path database_path elixir public_path storage_path
syn keyword phpFunctions camel_case class_basename ends_with snake_case str_limit starts_with str_contains str_finish str_is str_plural str_random str_singular str_slug studly_case trans trans_choice
syn keyword phpFunctions dd env with class_uses_recursive

highlight phpComment cterm=italic ctermfg=245 " GruvboxGray
highlight phpStringSingle     ctermfg=250
highlight phpStringDouble     ctermfg=250
highlight phpBacktick         ctermfg=250
highlight phpStringDelimiter  ctermfg=250
highlight phpNowDoc           ctermfg=250
highlight phpFunctions ctermfg=142
highlight phpKeyword ctermfg=167 " GruvboxRed
highlight phpType ctermfg=214
highlight phpFunction cterm=italic ctermfg=108
highlight phpClass ctermfg=223
highlight phpClassExtends    cterm=italic ctermfg=223
highlight phpClassImplements cterm=italic ctermfg=108
highlight phpClassDelimiter  cterm=italic ctermfg=108

" hi! link phpMagicConstants   Constant
" hi! link phpServerVars       Constant
" hi! link phpConstants        Constant
" hi! link phpBoolean          Boolean
" hi! link phpNumber           Number
" hi! link phpMethods          Function
" hi! link phpClasses          StorageClass
" hi! link phpException        Exception
" hi! link phpIdentifier       Identifier
" hi! link phpIdentifierSimply Identifier
" hi! link phpStatement        Statement
" hi! link phpStructure        Statement
" hi! link phpOperator         Operator
" hi! link phpMemberSelector   Operator
" hi! link phpInclude          PreProc
" hi! link phpDefine           PreProc
" hi! link phpSuperglobals     Type
" hi! link phpParent           Special
" hi! link phpSpecialChar      SpecialChar
" hi! link phpStrEsc           SpecialChar
" hi! link phpParentError      Error
" hi! link phpOctalError       Error
" hi! link phpTodo             Todo
" hi! link phpSplatOperator    phpOperator
" hi! link phpCommentStar      phpComment
" hi! link phpDocComment       phpComment
" hi! link phpCommentTitle     phpComment
" hi! link phpDocTags          phpComment
" hi! link phpDocParam         phpComment
" hi! link phpDocIdentifier    phpComment
" hi! link phpFCKeyword        phpKeyword
" hi! link phpSCKeyword        phpKeyword
" hi! link phpStaticClasses    phpClasses