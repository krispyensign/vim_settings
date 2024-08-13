" matches xxxxx%yyyyy and xxxxx%yyyyy(_)
syn match memberAccess /\w\+%\w\+/ contains=structName,accessor,fmethod
syn match structName /\w\+\ze%/ contained nextgroup=accessor
syn match accessor /%/ contained nextgroup=fident,fmethod
syn match fident /\w\+/ contained
syn match fmethod /\w\+\ze(/
hi def link structName Structure
hi def link accessor Operator
hi def link fident Identifier
hi def link fmethod Function

syn match fortranOperator '::'
syn match fortranOperator ','

" matches use xxxxx
syn region usage start=/use/ end=/$/ contains=usage,fspec
syn keyword usage use nextgroup=fspec
hi def link usage PreCondit
syn match fspec /.\+$/ contained
hi def link fspec Special

syn keyword fcall call
hi def link fcall Operator
hi! def link fortranIntrinsic Operator
