syn keyword adaBuiltinType Long_Float Long_Long_Integer
syn keyword adaSpecial Pre Ada Ada_2022 GNATCOLL

" matches .xxxx
syn match afterAdaChild /\.\@<=\w\+/ contains=adaNumber
hi def link afterAdaChild Identifier

" matches xxxx :
syn match afterAdaDefine /\w\+\s\+\ze:/
hi def link afterAdaDefine Identifier

" matches all xxxx;
syn match afterAdaSimpleDefOf /\(all\)\@<=\s\+\w\+\ze;/
hi def link afterAdaSimpleDefOf Type

" matches is new xxxx
syn match afterAdaSimpleDefOf /\(is new\)\@<=\s\+\w\+/
hi def link afterAdaSimpleDefOf Type

" matches of xxxx;
syn match afterAdaSimpleDefOf /\(of\)\@<=\s\+\w\+\ze;/
hi def link afterAdaSimpleDefOf Type

" matches :xxxx;
syn match afterAdaSimpleDef /:\@<=\s\+\w\+\ze;/ contains=adaOperator
hi def link afterAdaSimpleDef Type

" matches : xxxx :=
syn match afterAdaSimpleDef /:\@<=\s\+\w\+\s\+\ze:=/ contains=adaOperator
hi def link afterAdaSimpleDef Type

" matches : (zzzz.)+ xxxx;
syn match afterAdaSimpleDef /\(:\s\+\(\w\+\.\)\+\)\@<=\w\+\ze;/ contains=adaOperator
hi def link afterAdaSimpleDef Type

" matches : (zzzz.)+ xxxx :=
syn match afterAdaSimpleDef /\(:\s\+\(constant\s\+\)\=\(\w\+\.\)\+\)\@<=\w\+ \ze\(:=\)/ contains=adaOperator
hi def link afterAdaSimpleDef Type

" matches :xxxx)
syn match afterAdaSimpleDefParm /:\@<=\s\+\w\+\ze)/ contains=adaOperator
hi def link afterAdaSimpleDefParm Type

" matches : (zzzz.)+ xxxx)
syn match afterAdaSimpleDef /\(:\s\+\(\w\+\.\)\+\)\@<=\w\+\ze)/ contains=adaOperator
hi def link afterAdaSimpleDef Type

" matches :xxxx'Class;
syn match afterAdaSimpleDef /:\@<=\s\+\w\+\ze'/ contains=adaOperator
hi def link afterAdaSimpleDef Type

" matches ) return xxxx;
syn match afterAdaFunctionReturn /\()\_s\+return\_s\+\)\@<=\w\+\ze;/
hi def link afterAdaFunctionReturn Type

" matches ) return xxxx is
syn match afterAdaFunctionReturn /\()\_s\+return\_s\+\)\@<=\w\+\_s\+\ze\(is\)/
hi def link afterAdaFunctionReturn Type

" matches xxxx (_)
syn match afterAdaFunction /\w\+\_s\+\ze(/ contains=adaKeyword
hi def link afterAdaFunction Function

" matches function xxxx
syn match afterAdaFunction /\(function\_s*\)\@<=\w\+/
hi def link afterAdaFunction Function

" matches procedure xxxx
syn match afterAdaFunction /\(procedure\_s*\)\@<=\w\+/
hi def link afterAdaFunction Function

" matches end xxxx;
syn match afterAdaFunctionEnd /\(end\)\@<=\s\+\w\+\ze;/
hi def link afterAdaFunctionEnd Function

" matches type xxxx is
syn match afterAdaTypeIdentifier /\(type\s\+\|body\s\+\|package\s\+\)\@<=\w\+\ze is/
hi def link afterAdaTypeIdentifier Underlined

" matches xxxx renames
syn match afterAdaPackageIdentifier /\w\+\ze\s\+renames/
hi def link afterAdaPackageIdentifier Identifier

" matches (xxxx =>
syn match afterAdaKeywordBuild /\((\_s*\)\@<=\w\+\_s*\ze=>/
hi def link afterAdaKeywordBuild Special

" matches ,xxxx =>
syn match afterAdaKeywordBuild /\(,\_s*\)\@<=\w\+\_s*\ze=>/
hi def link afterAdaKeywordBuild Special

" matches xxxx'
syn match afterAdaVariableWithAttribute /\w\+\ze'/
hi def link afterAdaVariableWithAttribute Identifier

" matches xxxx.
syn match afterAdaParent /\w\+\ze\./ contains=adaNumber
hi def link afterAdaParent Normal
