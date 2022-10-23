if tools#PluginIsLoaded('lightline.vim')
	set laststatus=2
	set noshowmode
	let g:lightline = {}
	let g:lightline.colorscheme = 'gruvbox'
	let g:lightline.mode_map = {
				\ 'n' : 'N',
				\ 'i' : 'I',
				\ 'R' : 'R',
				\ 'v' : 'V',
				\ 'V' : 'VL',
				\ "\<C-v>": 'VB',
				\ 'c' : 'C',
				\ 's' : 'S',
				\ 'S' : 'SL',
				\ "\<C-s>": 'SB',
				\ 't': 'T',
				\ }
endif
