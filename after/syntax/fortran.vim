" add operators to list
syn match fortranOperator '%'
syn match fortranOperator '::'
syn match fortranOperator ','

" real is a type and not a special
syn keyword fortranType real

" matches xxxx(_)
syn match afterFortranFunction /\w\+\ze(/

" match type end-type keywords
syn match fortranKeyword /type\ze\s\+::/
syn match fortranKeyword /end type/
syn keyword fortranKeyword endtype
syn match fortranType /type\ze(/

" matches xxxxx%yyyyy and xxxxx%yyyyy(_)
syn match afterFortranMemberAccessSpec /%\w\+/ contains=fortranOperator,afterFortranIdentifier,afterFortranFunction
syn match afterFortranIdentifier /\w\+/ contained

" matches use xxxxx
syn match afterFortranUsageSpec /use\s\+\w\+/ contains=afterFortranUse,afterFortranUsage
syn keyword afterFortranUse use nextgroup=afterFortranUsage
syn match afterFortranUsage /.\+$/ contained

" matches implicit xxxxx
syn match afterFortranImplicitSpec /use\s\+\w\+/ contains=afterFortranUse,afterFortranImplicitMode
syn keyword afterFortranImplicit implicit nextgroup=afterFortranImplicitMode
syn match afterFortranImplicitMode /.\+$/ contained

" matches xxxx =
syn match afterFortranAssignmentSpec /\s\+\w\+\s\+=/ contains=fortranOperator,afterFortranAssignmentVar
syn match afterFortranAssignmentVar /\w\+/ contained

" reassign call keyword to keywords
hi clear fortranCall
hi def link fortranCall Keyword

" reassign unit header
hi clear fortranUnitHeader
hi def link fortranUnitHeader Keyword

" add after script custom links
hi def link afterFortranIdentifier Identifier
hi def link afterFortranFunction Function
hi def link afterFortranUse PreCondit
hi def link afterFortranUsage Special
hi def link afterFortranAssignmentVar Special
hi def link afterFortranImplicitMode Special
hi def link afterFortranImplicit PreCondit
