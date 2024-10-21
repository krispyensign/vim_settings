" TODO: remove duplicate highlighting rules

syn keyword afterPyThis self containedin=ALL
hi def link afterPyThis Special

syn match afterPyClass "\(def \)\|\.\@<!\<[A-Z]\+[a-zA-Z0-9_]*\>"
hi def link afterPyClass Type

syn match afterPyConst "\(def \)\|\.\@<!\<[A-Z_]\+[A-Z0-9_]*\>"
hi def link afterPyConst Identifier

" TODO: highlights incorrectly __init__ removed leading underscore for now
syn match afterPyFuncCall "\(def \)\|\.\@<!\<[a-z0-9]\+[a-zA-Z0-9_]*\ze\((\)"
hi def link afterPyFuncCall Function

" TODO: highlights incorrectly __init__ removed leading underscore for now
syn match afterPyClassCall "\(def \)\|\.\@<!\<[A-Z0-9]\+[a-zA-Z0-9_]*\ze\((\)"
hi def link afterPyClassCall Typedef

syn match afterPyProperty "\.\<[a-zA-Z0-9_]\+"
hi def link afterPyProperty Identifier

syn match afterPyMethodCall "\.\<[a-zA-Z0-9_]\+\ze\((\)"
hi def link afterPyMethodCall Function

" improve builtin object highlighting
syn keyword afterPyBuiltinObj __debug__ __doc__ __file__ __name__ __package__ __loader__
syn keyword afterPyBuiltinObj __spec__ __cached__ __annotations__
hi def link afterPyBuiltinObj Special

" improve builtin types highlighting
syn keyword afterPyBuiltinType float int str bool list tuple set dict
hi def link afterPyBuiltinType Type

" improve builtin c types highlighting
syn keyword afterPyBuiltinCTypes c_int c_double c_float c_char c_byte c_bool
hi def link afterPyBuiltinCTypes Type

syn keyword afterPyClassStatement class nextgroup=pyClassDef skipwhite
hi def link afterPyClassStatement Structure

syn match afterPyClassDef "\h\w*" display contained
hi def link afterPyClassDef Typedef

syn keyword afterPyFuncStatement def nextgroup=pyFuncDef skipwhite
hi def link afterPyFuncStatement Keyword

syn match afterPyFuncDef "\h\w*" display contained
hi def link afterPyFuncDef Function

syn match afterPyMathOperator "\%([~!^&|/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\.\.\.\|\.\.\|::\)"
hi def link afterPyMathOperator Operator

syn match afterPythonBitwiseOperator "\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"
hi def link afterPyBitwiseOperator Operator

syn match afterPythonAssignmentOperator 	"\%(=\)"
hi def link afterPyAssignmentOperator 	Operator

syn match afterPythonWalrusOperator 		"\%(:=\)"
hi def link afterPyWalrusOperator 		Operator

syn match afterPythonStarOperator 		"\%(\*\|\*\*\)"
hi def link afterPyStarOperator 			Operator
