" omnicomplete
inoremap <expr> <Nul> Auto_complete_string()
inoremap <expr> <C-Space> Auto_complete_string()

" omnicomplete
func! Auto_complete_string()
	if pumvisible()
		return "\<C-n>"
	else
		return "\<C-x>\<C-o>\<C-r>=Auto_complete_opened()\<CR>"
	end
endfunc

func! Auto_complete_opened()
	if pumvisible()
		return "\<Down>"
	end
	return ""
endfunc
