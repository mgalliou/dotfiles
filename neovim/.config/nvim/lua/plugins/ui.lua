return {
	{
		'lukas-reineke/indent-blankline.nvim',
		event = "BufReadPost",
		opts = {
			-- TODO: improve configuration
			show_current_context = true,
			show_end_of_line = true,
			space_char_blankline = " ",
		},
	},
	{
		'asiryk/auto-hlsearch.nvim',
		event = "BufReadPost",
		config = true
	},
	{
		'm-demare/hlargs.nvim',
		event = "CursorMoved",
		opts = {
			highlight = {
				italic = true
			},
		},
	},
	-- TODO: configure
	{
		'RRethy/vim-illuminate',
		event = "BufReadPost"
	},
	-- TODO: add configuration/keymaps
	{
		'folke/todo-comments.nvim',
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = true
	},
	{ 'kyazdani42/nvim-web-devicons' },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = 'gruvbox'
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename', "require('nvim-lightbulb').get_status_text()" },
				lualine_x = { 'filetype' },
				lualine_y = {},
				lualine_z = { 'progress' }
			}
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			current_line_blame = false,
			current_line_blame_opts = {
				delay = 500,
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- TODO: compare behavior with suggested bind; disable unused
				-- keybind
				-- Navigation
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")
				-- Actions
				map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', "Stage Hunk")
				map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', "Reset Hunk")
				map('n', '<leader>hS', gs.stage_buffer, "Stage Buffer")
				map('n', '<leader>hu', gs.undo_stage_hunk, "Undo Stage Hunk")
				map('n', '<leader>hR', gs.reset_buffer, "Reset Buffer")
				map('n', '<leader>hp', gs.preview_hunk, "Prevew Hunk")
				map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, "Blame Line")
				map('n', '<leader>htb', gs.toggle_current_line_blame, "Toggle Blame")
				map('n', '<leader>hd', gs.diffthis, "Diff This")
				map('n', '<leader>hD', function() gs.diffthis('~') end, "Diff This ~")
				map('n', '<leader>td', gs.toggle_deleted, "Toggle Deleted")
				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "GitSigns Select Hunk")
			end
		}
	},
	{
		'folke/noice.nvim',
		enabled = false,
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify'
		},
		config = {
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
			}
		}
	}
}
