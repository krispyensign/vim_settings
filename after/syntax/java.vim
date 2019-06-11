" highlight operators
syntax match _Operator "[-+&|<>=!\/~,;:*%&^?]" containedin=javaParenT
syntax match _Lambda "->" containedin=javaParenT

" highlight methods
syntax match _memberFunc "\.\s*\w\+\s*(\@=" containedin=javaParenT
syntax match _memberFuncDef "\<\s*\w\+\s*(\@=" containedin=javaParenT
syntax match ClassName display '\v<[A-Z_]+[_a-zA-Z0-9]*' containedin=javaParenT
" syntax match ClassName display '\.\@<=\*'
highlight link ClassName TypeDef

" to resolve conflict with comment markers
syntax region _Comment start="\/\*" end="\*\/"
syntax match _Comment "\/\/.*$"
hi link _Comment Comment

" Linkage
" highlight link javaScopeDecl Statement
" highlight link javaType Type
" highlight link javaDocTags PreProc
highlight link _Operator Operator
highlight link _Lambda Operator
highlight link _memberFunc Function
highlight link _memberFuncDef Function

hi! link Type GruvboxRed
hi! link Class GruvboxOrangeBold
hi! link DefinedName GruvboxGreen
hi! link EnumerationValue GruvboxGreenBold
hi! link Function GruvboxYellow
hi! link Enumeration GruvboxYellowBold
hi! link EnumerationName GruvboxYellowBold
hi! link Constant GruvboxBlue
hi! link LocalVariable GruvBoxBlueBold
hi! link Member GruvboxPurple
hi! link Method GruvboxPurple
hi! link Namespace GruvboxPurpleBold
hi! link Function GruvboxAqua
hi! link Structure GruvboxAquaBold
hi! link Union GruvboxOrange
hi! link GlobalVariable GruvboxOrangeBold
hi! link Extern GruvboxGray
hi! link Field GruvboxGreen
hi! link Interface GruvboxPurpleBold
hi! link Package GruveboxBlueBold
hi! link StorageClass GruvboxRed

hi Operator guifg=#867fe8
