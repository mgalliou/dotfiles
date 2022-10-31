if tools#PluginIsLoaded('gitgutter')
	let g:gitgutter_signs = 0
	let g:gitgutter_highlight_linenrs = 1

	highlight link GitGutterAddLineNr DiffAdd
	highlight link GitGutterChangeLineNr DiffChange
	highlight link GitGutterDeleteLineNr DiffDelete
	highlight link GitGutterChangeDeleteLineNr GitGutterChangeLineDefault
endif
