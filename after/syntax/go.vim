hi clear goParamType
hi def link goParamType Type

hi clear goFunctionReturn

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

let propA = "'" .. s:identifier .. s:end_match .. ':' .. "'"
exec 'syn match goFieldPropA ' .. propA
hi def link goFieldPropA Identifier

let propB = "'" .. s:bol .. s:white_space .. s:identifier .. s:end_match .. s:any .. '[^,]' .. s:eol .. "'"
exec 'syn match goFieldPropB ' .. propB
hi def link goFieldPropB Identifier

let propC = "'" .. s:bol .. s:white_space .. s:identifier .. s:any ..
			\ s:start_match .. s:identifier .. s:end_match .. s:any .. '[^,]' .. s:eol .. "'"
exec 'syn match goFieldPropC ' .. propC
hi def link goFieldPropC Identifier
" let l:white_space = '\s\+'
" let l:start = '^'
" let l:identifier = '[a-za-z_]\+[a-za-z0-9_]*'
" let l:match_proc = l:start .. l:white_space .. l:identifier .. l:white_space '.*\zs[a-zA-Z_]\+[a-zA-Z0-9_]*\ze.*[^,]$'
" exec syn match goFieldPropC l:match_proc
" hi def link goFieldPropC Type
