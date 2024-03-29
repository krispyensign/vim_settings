syn keyword	pyThis 			self in containedin=ALL
hi def link pyThis 			Special

syn match	pyClass 	 	"\(def \)\|\.\@<!\<[A-Z_]\+[a-zA-Z0-9_]*\>"
hi def link pyClass 		Type

syn match	pyConst 	 	"\(def \)\|\.\@<!\<[A-Z_]\+[A-Z0-9_]*\>"
hi def link pyConst			Special

syn match	pyFuncCall 		"\(def \)\|\.\@<!\<[a-z0-9_]\+[a-zA-Z0-9_]*\ze\((\)"
hi def link pyFuncCall 		Function

syn match	pyClassCall 	"\(def \)\|\.\@<!\<[A-Z0-9_]\+[a-zA-Z0-9_]*\ze\((\)"
hi def link pyClassCall 	Function

syn match 	pyProperty 		"\.\<[a-zA-Z0-9_]\+"
hi def link pyProperty 		Identifier

syn match 	pyMethodCall 	"\.\<[a-zA-Z0-9_]\+\ze\((\)"
hi def link pyMethodCall 	Function

" improve builtin object highlighting
syn keyword pyBuiltinObj 	__debug__ __doc__ __file__ __name__ __package__ __loader__
syn keyword pyBuiltinObj 	__spec__ __cached__ __annotations__
hi def link pyBuiltinObj 	Special

syn keyword pyClassStatement 	class nextgroup=pyClassDef skipwhite
hi def link pyClassStatement 	Statement

syn match   pyClassDef			"\h\w*" display contained
hi def link pyClassDef 			Typedef

syn keyword pyFuncStatement 	def nextgroup=pyFuncDef skipwhite
hi def link pyFuncStatement 	Statement

syn match   pyFuncDef			"\h\w*" display contained
hi def link pyFuncDef 			Function

syn match pyMathOperator 			"\%([~!^&|/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\.\.\.\|\.\.\|::\)"
hi def link pyMathOperator 			Operator

syn match pythonBitwiseOperator 	"\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"
hi def link pyBitwiseOperator 		Operator

syn match pythonAssignmentOperator 	"\%(=\)"
hi def link pyAssignmentOperator 	Operator

syn match pythonWalrusOperator 		"\%(:=\)"
hi def link pyWalrusOperator 		Operator

syn match pythonStarOperator 		"\%(\*\|\*\*\)"
hi def link pyStarOperator 			Operator

