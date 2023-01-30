return {
	{
		'dstein64/vim-startuptime',
		cmd = "StartupTime",
		config = function()
			vim.g.startup_tries = 10
		end
	},
	{
		'folke/which-key.nvim',
		config = function ()
			--TODO: Improve configuration
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({
			})
		end,
	},
	{ "tpope/vim-repeat" },
}
