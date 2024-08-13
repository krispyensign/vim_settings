" matches xxxxx%yyyyy and xxxxx@yyyyy(_)
syn match memberAccess /\w\+%\w\+/ contains=structName,accessor,fmethod
syn match structName /\w\+\ze%/ contained nextgroup=accessor
hi def link structName Structure
syn match accessor /%/ contained nextgroup=fident,fmethod
hi def link accessor Operator
syn match fident /\w\+/ contained
hi def link fident Identifier
syn match fmethod /\w\+\ze(/ contained
hi def link fmethod Function

syn match fortranOperator '::'
syn match fortranOperator ','

syn region usage start=/use/ end=/$/ contains=usage,fspec
syn keyword usage use nextgroup=fspec
hi def link usage PreCondit
syn match fspec /.\+$/ contained
hi def link fspec Special
