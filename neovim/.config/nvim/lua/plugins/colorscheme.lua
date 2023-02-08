return {
	{
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		-- TODO: improve config (e.g. remove defaults)
		config = function()
			require("gruvbox").setup({
				undercurl = true,
				underline = true,
				bold = true,
				italic = true,
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			-- NOTE: temporary fix for `noice` command line border color
			-- from "https://github.com/ellisonleao/gruvbox.nvim/issues/160"
			vim.cmd([[
			function! FixGruvboxForNoice() abort
				if g:colors_name == "gruvbox"
					highlight NoiceCmdlinePopupBorderCmdline guifg=#83a598 guibg=NONE
					highlight NoiceCmdlinePopupBorderFilter guifg=#83a598 guibg=NONE
					highlight NoiceCmdlinePopupBorderHelp guifg=#83a598 guibg=NONE
					highlight NoiceCmdlinePopupBorderInput guifg=#83a598 guibg=NONE
					highlight NoiceCmdlinePopupBorderLua guifg=#83a598 guibg=NONE
					highlight NoiceCmdlinePopupBorderSearch guifg=#fabd2f guibg=NONE

					highlight NoiceCmdlineIconCmdline guifg=#83a598 guibg=NONE
					highlight NoiceCmdlineIconFilter guifg=#83a598 guibg=NONE
					highlight NoiceCmdlineIconHelp guifg=#83a598 guibg=NONE
					highlight NoiceCmdlineIconInput guifg=#83a598 guibg=NONE
					highlight NoiceCmdlineIconLua guifg=#83a598 guibg=NONE
					highlight NoiceCmdlineIconSearch guifg=#fabd2f guibg=NONE
				endif
			endfunction

			augroup ApplyFixGruvboxForNoice
				autocmd!
				autocmd ColorScheme * call FixGruvboxForNoice()
			augroup END

			silent !rm $VIMRUNTIME/colors/*.vim &> /dev/null
			set background=dark
			colorscheme gruvbox
			highlight link GitSignsChange GruvboxYellowSign
			]])
		end,
	}
}
