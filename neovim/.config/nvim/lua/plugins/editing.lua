return {
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-surround", event = { "BufReadPost", "BufNewFile" } },
	{ "tpope/vim-commentary", event = { "BufReadPost", "BufNewFile" } },
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
		"junegunn/vim-easy-align",
		enabled = false,
		cmd = "EasyAlign",
		keys = {
			{ "<leader>ga", ":EasyAlign", mode = { "n", "v" }, desc = "Align with easy-align" },
		},
	},
}
