syn keyword adaBuiltinType Long_Float
syn keyword adaSpecial Pre

" matches all xxxx;
syn match afterAdaSimpleDefOf /\(all\)\@<=\s\+\w\+\ze;/
hi def link afterAdaSimpleDefOf Type

" matches of xxxx;
syn match afterAdaSimpleDefOf /\(of\)\@<=\s\+\w\+\ze;/
hi def link afterAdaSimpleDefOf Type

" matches :xxxx;
syn match afterAdaSimpleDef /:\@<=\s\+\w\+\ze;/ contains=afterAdaFunction,adaOperator
hi def link afterAdaSimpleDef Type

" matches :xxxx)
syn match afterAdaSimpleDefParm /:\@<=\s\+\w\+\ze)/ contains=afterAdaFunction,adaOperator
hi def link afterAdaSimpleDefParm Type

" matches :xxxx'Class;
syn match afterAdaSimpleDef /:\@<=\s\+\w\+\ze'/ contains=afterAdaFunction,adaOperator
hi def link afterAdaSimpleDef Type

" matches .xxxx but not .xxxx.
syn match afterAdaChild /\.\@<=\w\+\.\@!/ contains=afterAdaFunction,adaOperator
hi def link afterAdaChild Identifier

" matches xxxx (_)
syn match afterAdaFunction /\w\+\_s\+\ze(/ contains=adaKeyword
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

" matches xxxx =>
syn match afterAdaKeywordBuild /\w\+\s\+\ze=>/
hi def link afterAdaKeywordBuild Special

" matches xxxx'
syn match afterAdaVariableWithAttribute /\w\+\ze'/
hi def link afterAdaVariableWithAttribute Identifier
