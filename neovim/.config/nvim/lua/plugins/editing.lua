---@type LazyPluginSpec[]
return {
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
	},
	{
		"trmckay/based.nvim",
		keys = {
			{
				"<C-b>",
				function()
					require("based").convert()
				end,
				desc = "Try to detect base and convert",
			},
			{
				"<leader>Bh",
				function()
					require("based").convert("hex")
				end,
				desc = "Convert form hex",
			},
			{
				"<leader>Bd",
				function()
					require("based").convert("dec")
				end,
				desc = "Convert from decimal",
			},
		},
	},
	{
		"nvim-mini/mini.align",
		version = false,
		event = "VeryLazy",
		config = true,
	},
	{
		"nvim-mini/mini.pairs",
		version = false,
		event = "VeryLazy",
		config = true,
	},
	{
		"nemanjamalesija/smart-paste.nvim",
		event = "VeryLazy",
		config = true,
	},
}
