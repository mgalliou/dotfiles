return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen" }
		-- TODO: configure
	},
	{
		"folke/trouble.nvim",
		-- TODO: configure
		opts = {
			use_diagnostic_signs = true
		}
	},
	{
		"nvim-neorg/neorg",
		ft = "norg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.norg.dirman"] = {
					config = {
						workspaces = {
							work = "~/notes/work",
							home = "~/notes/home",
						},
					},
				},
				["core.norg.concealer"] = {},
				["core.norg.completion"] = {
					config = { engine = "nvim-cmp" },
				},
				["core.integrations.nvim-cmp"] = {},
			},
		},
		keys = {
			{ "<leader>nww", "<cmd>Neorg workspace work<CR>", desc = "Neorg work workspace" },
			{ "<leader>njt", "<cmd>Neorg journal today<CR>", desc = "Neorg today journal" }
		},
	},
	{
		-- TODO: configure zk-nvim
		"mickael-menu/zk-nvim",
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{
		"trmckay/based.nvim",
		keys = {
			{ "<C-b>",      function() require("based").convert() end,      desc = "Try to detect base and convert" },
			{ "<leader>Bh", function() require("based").convert("hex") end, desc = "Convert form hex" },
			{ "<leader>Bd", function() require("based").convert("dec") end, desc = "Convert from decimal" },
		}
	}
}
