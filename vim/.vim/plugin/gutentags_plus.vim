if tools#PluginIsLoaded("gutentags_plus")
	" enable gtags module
	let g:gutentags_modules = ['ctags', 'gtags_cscope']
	" config project root markers.
	let g:gutentags_project_root = ['.root']
	" generate datebases in my cache directory, prevent gtags files polluting my project
	let g:gutentags_cache_dir = expand('~/.cache/tags')
endif
