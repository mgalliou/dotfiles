return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = "BufReadPost",
	opts = {
		auto_install = { enable = true },
		highlight = { enable = true, additional_vim_regex_highlighting = true },
		indent = { enable = true },
		incremental_selection = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
