local function Z(cmd, opt)
	return function()
		require("zk.commands").get(cmd)(opt)
	end
end
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
		},
		keys = {
			{ "<leader>xx", ":TroubleToggle<CR>", desc = "Toggle Trouble" },
			{ "<leader>xt", ":TodoTrouble<CR>", desc = "Toggle Trouble" },
		}

	},
	{
		"nvim-neorg/neorg",
		ft = "norg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							work = "~/notes/work",
							home = "~/notes/home",
						},
					},
				},
				["core.concealer"] = {},
				["core.completion"] = {
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
		"mickael-menu/zk-nvim",
		config = function ()
			require("zk").setup({
				picker = "telescope",
				lsp = {
					on_attach = require("tools").on_attach
				},
			})
		end,
		keys = {
			{ "<leader>zf", Z("ZkNotes", {}), desc = "Find note" },
			{
				"<leader>zn",
				function()
					local title = vim.fn.input("Title: ")
					require("zk").new({ title = title })
				end,
				desc = "New note"
			},
			{
				"<leader>zc",
				function()
					local title = vim.fn.input("Title: ")
					require("zk.commands").get("ZkNewFromContentSelection")({ title = title })
				end,
				desc = "New note with selection as title"
			},
			{ "<leader>zt", Z("ZkNewFromTitleSelection", {}), desc = "New note with selection as content" },
			{ "<leader>zx", Z("ZkLinks"), desc = "Pick links in current buffer" },
			{ "<leader>zb", Z("ZkBackLinks"), desc = "Pick backlinks in the current buffer" },
			{ "<leader>zl", Z("ZkInsertLink"), desc = "Pick backlinks in the current buffer" },
		}
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{
		"trmckay/based.nvim",
		keys = {
			{ "<C-b>",      function() require("based").convert() end,      desc = "Try to detect base and convert" },
			{ "<leader>Bh", function() require("based").convert("hex") end, desc = "Convert form hex" },
			{ "<leader>Bd", function() require("based").convert("dec") end, desc = "Convert from decimal" },
		}
	},
	{
		"junegunn/vim-easy-align",
		enabled = false,
		cmd = "EasyAlign",
		keys = {
			{ "<leader>ga", ":EasyAlign", mode = { 'n', 'v' }, desc = "Align with easy-align" },
		}
	}
}
