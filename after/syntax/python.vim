syn keyword pythonThis self in containedin=ALL
hi def link pythonThis Constant
syn match pythonFunctionCalls "\(def \)\|\.\@<!\<[a-z0-9_]\+\ze\((\)"
syn match pythonProperties "\.\<[a-z0-9_]\+"
syn match pythonMethodCalls "\.\<[a-z0-9_]\+\ze\((\)"

