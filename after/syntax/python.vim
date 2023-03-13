syn keyword pythonThis self in containedin=ALL
hi def link pythonThis Constant
syn match pythonFunctionCalls "\(def \)\|\.\@<!\<[a-z0-9_]\+\ze\((\)"
syn match pythonProperties "\.\<[a-z0-9_]\+"
syn match pythonMethodCalls "\.\<[a-z0-9_]\+\ze\((\)"

hi Function guifg=#3399FF gui=bold
hi pythonFunctionCalls guifg=orange gui=italic
hi pythonMethodCalls guifg=#2288ee gui=italic
hi pythonProperties guifg=darkyellow gui=italic

