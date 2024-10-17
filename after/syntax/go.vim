hi clear goParamType
hi def link goParamType Type

hi clear goFunctionReturn
hi clear goParamName

hi clear goFunctionCall
hi def link goFunctionCall Function

hi clear goImportString
hi def link goImportString Include

hi clear goField
hi def link goField Identifier

let s:white_space = '\s\+'
let s:bol = '^'
let s:identifier = '[a-zA-Z_]\+[a-zA-Z0-9_]*'
let s:eol = '$'
let s:start_match = '\zs'
let s:end_match = '\ze'
let s:any = '.*'

" example asdf:  int32,
let propA = "'" .. s:identifier .. s:end_match .. ':' .. s:white_space .. "'"
exec 'syn match goFieldPropA ' .. propA
hi def link goFieldPropA Identifier
"
" let propB = "'" .. s:bol .. s:white_space .. s:identifier .. s:end_match .. s:any .. '[^,]' .. s:eol .. "'"
" exec 'syn match goFieldPropB ' .. propB
" hi def link goFieldPropB Identifier
"
" let propC = "'" .. s:bol .. s:white_space .. s:identifier .. s:any ..
" 			\ s:start_match .. s:identifier .. s:end_match .. s:any .. '[^,]' .. s:eol .. "'"
" exec 'syn match goFieldPropC ' .. propC
" hi def link goFieldPropC Identifier
