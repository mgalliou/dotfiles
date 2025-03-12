local highlight = {
	"CursorColumn",
	"Whitespace",
}

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			icons = {
				rules = false,
			},
			spec = {
				{ "<BS>", desc = "Decrement Selection", mode = "x" },
				{ "<C-space>", desc = "Increment Selection", mode = { "x", "n" } },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "g", group = "goto" },
				{ "z", group = "fold" },
				{ "<leader>c", group = "code" },
				{ "<leader>h", group = "hunks" },
				{ "<leader>B", group = "bases" },
				{ "<leader>s", group = "search" },
				{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
				{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
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
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "gruvbox",
				component_separators = { left = "|", right = "|" },
				section_separators = {},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 4 } },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "neo-tree" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "" },
			whitespace = { highlight = highlight, remove_blankline_trail = false },
		},
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"m-demare/hlargs.nvim",
		event = "CursorMoved",
		opts = {
			highlight = {
				italic = true,
			},
		},
	},
	{
		"asiryk/auto-hlsearch.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
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
		event = { "BufReadPost", "BufNewFile" },
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
				end)

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)
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
	{ "j-hui/fidget.nvim", opts = {} },
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
}
