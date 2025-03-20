local function Z(cmd, opt)
	return function()
		require("zk.commands").get(cmd)(opt)
	end
end

---@type LazyPluginSpec[]
return {
	{ "tpope/vim-fugitive" },
	{ "nanotee/zoxide.vim" },
	{
		"mickael-menu/zk-nvim",
		enabled = false,
		config = function()
			require("zk").setup({
				picker = "telescope",
				lsp = {
					on_attach = Utils.on_attach,
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
				desc = "New note",
			},
			{
				"<leader>zc",
				function()
					local title = vim.fn.input("Title: ")
					require("zk.commands").get("ZkNewFromContentSelection")({ title = title })
				end,
				desc = "New note with selection as title",
			},
			{ "<leader>zt", Z("ZkNewFromTitleSelection", {}), desc = "New note with selection as content" },
			{ "<leader>zx", Z("ZkLinks"), desc = "Pick links in current buffer" },
			{ "<leader>zb", Z("ZkBackLinks"), desc = "Pick backlinks in the current buffer" },
			{ "<leader>zl", Z("ZkInsertLink"), desc = "Pick backlinks in the current buffer" },
		},
	},
	{
		"nvim-neorg/neorg",
		enabled = false,
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
			{ "<leader>njt", "<cmd>Neorg journal today<CR>", desc = "Neorg today journal" },
		},
	},
}
