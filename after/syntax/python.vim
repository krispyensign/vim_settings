syn keyword	pythonThis 			self in containedin=ALL
syn match	pythonClass 	 	"\(def \)\|\.\@<!\<[A-Z_]\+[a-zA-Z0-9_]*\>"
syn match	pythonConstant 	 	"\(def \)\|\.\@<!\<[A-Z_]\+[A-Z0-9_]*\>"
syn match	pythonFunctionCall 	"\(def \)\|\.\@<!\<[a-zA-Z0-9_]\+[a-zA-Z0-9_]*\ze\((\)"
syn match 	pythonProperty 		"\.\<[a-zA-Z0-9_]\+"
syn match 	pythonMethodCall 	"\.\<[a-zA-Z0-9_]\+\ze\((\)"

" improve builtin object highlighting
syn keyword Structure __debug__ __doc__ __file__ __name__ __package__ __loader__
syn keyword Structure __spec__ __cached__ __annotations__

syn keyword pythonStatement 	class def nextgroup=pythonFunctionDef skipwhite
syn match   pythonFunctionDef	"\h\w*" display contained

syn match pythonMathOperator 		"\%([~!^&|/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\.\.\.\|\.\.\|::\)"
syn match PythonBitwiseOperator 	"\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"
syn match PythonAssignmentOperator 	"\%(=\)"
syn match PythonWalrusOperator 		"\%(:=\)"
syn match PythonStarOperator 		"\%(\*\|\*\*\)"

hi def link pythonThis 					Constant
hi def link pythonConstant				Special
hi def link pythonFunctionCall 			Function
hi def link pythonClass 				Type
hi def link pythonMethodCall 			Function
hi def link pythonProperty 				Identifier
hi def link pythonStatement 			Statement
hi def link pythonFunctionDef 			Type
hi def link PythonMathOperator 			Operator
hi def link PythonBitwiseOperator 		Operator
hi def link PythonAssignmentOperator 	Operator
hi def link PythonWalrusOperator 		Operator
hi def link PythonStarOperator 			Operator

