require('lualine').setup {
	options = {
		theme = 'gruvbox'
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename', "require('nvim-lightbulb').get_status_text()"},
		lualine_x = {},
		lualine_y = {'filetype'},
		lualine_z = {'progress'}
	}
}
