if tools#PluginIsLoaded("vim-gutentags")
	if 1 != executable("ctags")
		let g:gutentags_enabled = 0
	endif
endif
