---@type LazyPluginSpec[]
return {
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startup_tries = 10
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
}
