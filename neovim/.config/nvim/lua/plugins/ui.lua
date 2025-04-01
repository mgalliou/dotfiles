---@type LazyPluginSpec[]
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		---@type wk.Opts
		opts = {
			preset = "helix",
			icons = {
				rules = false,
			},
			spec = {
				{ "<BS>", desc = "Decrement Selection", mode = "x" },
				{ "<C-space>", desc = "Increment Selection", mode = { "x", "n" } },
				{ "[", group = "prev", icon = { icon = "󰒮 ", color = "orange" } },

				{ "]", group = "next", icon = { icon = "󰒭 ", color = "orange" } },
				{ "g", group = "goto", icon = { icon = " ", color = "orange" } },
				{ "z", group = "fold", icon = { icon = "", color = "orange" } },
				{ "<leader>c", group = "code", icon = { icon = "󰘦 ", color = "yellow" } },
				{ "<leader>h", group = "hunks", icon = { icon = " ", color = "yellow" } },
				{ "<leader>B", group = "bases", icon = { icon = " ", color = "yellow" } },
				{ "<leader>f", group = "find", icon = { icon = " ", color = "yellow" } },
				{ "<leader>s", group = "search", icon = { icon = " ", color = "yellow" } },
				{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "yellow" } },
				{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "yellow" } },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<c-w><space>",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
	},
	{
		"echasnovski/mini.icons",
		lazy = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = {},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { { "filename", path = 4 }, "diff", "diagnostics" },

				lualine_x = { { "lsp_status", ignore_lsp = { "null-ls" } } },
				lualine_y = { "filetype" },
				lualine_z = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
			},
		},
	},
	{
		"m-demare/hlargs.nvim",
		event = Utils.buf_events,
		opts = {
			highlight = {
				italic = true,
			},
		},
	},
	{
		"asiryk/auto-hlsearch.nvim",
		event = Utils.buf_events,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		event = Utils.buf_events,
		cmd = { "TodoTrouble", "TodoTelescope" },
		---@class TodoOptions
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo Comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo Comment",
			},
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
			{
				"<leader>xT",
				"<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
				desc = "Todo/Fix/Fixme (Trouble)",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = Utils.buf_events,
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function()
					gitsigns.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gitsigns.nav_hunk("first")
				end, "First Hunk")

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, "Stage/Unstage Hunk")
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage/Unstage Hunk")
				map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Hunk")
				map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
				map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")
				map("n", "<leader>hp", gitsigns.preview_hunk, "Prevew Hunk")
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>htb", gitsigns.toggle_current_line_blame, "Toggle current line Blame")
				map("n", "<leader>hd", gitsigns.diffthis, "Diff This")
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, "Diff This ~")
				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end, "Open quickfix with changes")
				map("n", "<leader>hq", gitsigns.setqflist, "Open quickfix with changes (buffer)")

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select Hunk")
			end,
		},
	},
	{
		"j-hui/fidget.nvim",
		enabled = false,
		opts = {},
	},
	{
		"folke/noice.nvim",
		enabled = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- over ride markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			messages = {
				enabled = false,
			},
		},
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
}
