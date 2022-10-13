function tools#PluginIsLoaded(plugin)
	return has_key(g:plugs, a:plugin)
endfunction

function tools#ToggleLineNumberMode()
	if &number == 0 && &relativenumber == 0
		set number
	elseif &number != 0 && &relativenumber == 0
		set number
		set relativenumber
	elseif &relativenumber != 0
		set nonumber
		set norelativenumber
	endif
endfunction
