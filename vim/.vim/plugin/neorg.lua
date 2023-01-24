require("neorg").setup {
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
}

vim.keymap.set('n', "<leader>nww", ":Neorg workspace work<CR>", nil)
vim.keymap.set('n', "<leader>njt", ":Neorg journal today<CR>", nil)
