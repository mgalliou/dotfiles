---@type LazyPluginSpec[]
return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		---@module "gruvbox"
		---@type GruvboxConfig
		opts = {
			transparent_mode = false,
		},
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
