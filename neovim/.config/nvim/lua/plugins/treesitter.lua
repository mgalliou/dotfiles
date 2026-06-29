---@type LazyPluginSpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "VeryLazy", unpack(Utils.buf_events) },
		cmd = { "TSInstall", "TSUpdate", "TSLog", "TSUninstall" },
		opts = {
			auto_install = true,
			ensure_installed = {
				"bash",
				"diff",
				"fish",
				"gitcommit",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				desc = "Start treesitter highlighting",
				group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		--- @class TSTextObjects.Config
		opts = {
			select = {
				lookahead = true,
				lookbehind = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			for _, spec in ipairs({
				{ "ak", "@block.outer", "around block" },
				{ "ik", "@block.inner", "inside block" },
				{ "ac", "@class.outer", "around class" },
				{ "ic", "@class.inner", "inside class" },
				{ "a?", "@conditional.outer", "around conditional" },
				{ "i?", "@conditional.inner", "inside conditional" },
				{ "af", "@function.outer", "around function" },
				{ "if", "@function.inner", "inside function" },
				{ "ao", "@loop.outer", "around loop" },
				{ "io", "@loop.inner", "inside loop" },
				{ "aa", "@parameter.outer", "around argument" },
				{ "ia", "@parameter.inner", "inside argument" },
			}) do
				vim.keymap.set({ "x", "o" }, spec[1], function()
					select(spec[2])
				end, { desc = spec[3] })
			end

			local move = require("nvim-treesitter-textobjects.move")
			for _, spec in ipairs({
				{ "[f", move.goto_previous_start, "@function.outer", "prev function start" },
				{ "]f", move.goto_next_start, "@function.outer", "next function start" },
				{ "[c", move.goto_previous_start, "@class.outer", "prev class start" },
				{ "]c", move.goto_next_start, "@class.outer", "next class start" },
				{ "[a", move.goto_previous_start, "@parameter.inner", "prev param" },
				{ "]a", move.goto_next_start, "@parameter.inner", "next param" },
				{ "[v", move.goto_previous_start, "@assignment.outer", "prev assignment" },
				{ "]v", move.goto_next_start, "@assignment.outer", "next assignment" },
				{ "[F", move.goto_previous_end, "@function.outer", "prev function end" },
				{ "]F", move.goto_next_end, "@function.outer", "next function end" },
				{ "[C", move.goto_previous_end, "@class.outer", "prev class end" },
				{ "]C", move.goto_next_end, "@class.outer", "next class end" },
				{ "[A", move.goto_previous_end, "@parameter.inner", "prev param end" },
				{ "]A", move.goto_next_end, "@parameter.inner", "next param end" },
			}) do
				vim.keymap.set({ "n", "x", "o" }, spec[1], function()
					spec[2](spec[3], "textobjects")
				end, { desc = spec[4] })
			end

			local swap = require("nvim-treesitter-textobjects.swap")
			for _, spec in ipairs({
				{ "<leader>[f", swap.swap_previous, "@function.outer", "swap prev function" },
				{ "<leader>]f", swap.swap_next, "@function.outer", "swap next function" },
				{ "<leader>[c", swap.swap_previous, "@class.outer", "swap prev class" },
				{ "<leader>]c", swap.swap_next, "@class.outer", "swap next class" },
				{ "<leader>[a", swap.swap_previous, "@parameter.inner", "swap prev arg" },
				{ "<leader>]a", swap.swap_next, "@parameter.inner", "swap next arg" },
				{ "<leader>[v", swap.swap_previous, "@assignment.outer", "swap prev assignment" },
				{ "<leader>]v", swap.swap_next, "@assignment.outer", "swap next assignment" },
			}) do
				vim.keymap.set("n", spec[1], function()
					spec[2](spec[3])
				end, { desc = spec[4] })
			end
		end,
	},
	{
		"mtrajano/tssorter.nvim",
		version = "*",
		event = { "VeryLazy" },
		opts = {
			sortables = {
				gitconfig = {
					section_header = {
						node = "section",
					},
					name = {
						node = "variable",
					},
				},
			},
		},
	},
}
