---@type LazyPluginSpec[]
return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		init = function()
			vim.api.nvim_set_hl(0, "FloatTitle", { link = "NormalFloat" })
		end,
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},
	{
		"rose-pine/neovim",
		lazy = true,
		name = "rose-pine",
	},
}
