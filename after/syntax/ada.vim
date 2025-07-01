syn keyword adaBuiltinType Long_Float
syn keyword adaKeyword Pre

" matches xxxx.
" syn match afterAdaParent /\w\+\ze\./
" hi def link afterAdaParent Include

" matches .xxxx
syn match afterAdaChild /\.\w\+/
hi def link afterAdaChild Type

" matches xxxx (_)
syn match afterAdaFunction /\w\+\_s\+\ze(/
hi def link afterAdaFunction Function

" matches xxxx :
syn match afterAdaDefine /\w\+\s\+\ze:/
hi def link afterAdaDefine Identifier

" matches xxxx is
syn match afterAdaTypeIdentifier /\w\+\ze\s\+is/
hi def link afterAdaTypeIdentifier Underlined

" matches xxxx renames
syn match afterAdaPackageIdentifier /\w\+\ze\s\+renames/
hi def link afterAdaPackageIdentifier Identifier
