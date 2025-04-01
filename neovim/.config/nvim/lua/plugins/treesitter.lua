---@type LazyPluginSpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		event = { "VeryLazy", unpack(Utils.buf_events) },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<C-space>", desc = "Increment Selection" },
			{ "<BS>", desc = "Decrement Selection", mode = "x" },
		},
		init = function(plugin)
			-- from LazyVim https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
			require("lazy.core.loader").add_to_rtp(plugin)
			pcall(require, "nvim-treesitter.query_predicates")
		end,
		main = "nvim-treesitter.configs",
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "VeryLazy" },
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
