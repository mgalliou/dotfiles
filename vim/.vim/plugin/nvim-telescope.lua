require('telescope').setup {
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = { ".git/" }
	},
	pickers = {
		find_files = {
			hidden = true
		}
	}
}

local builtin = require('telescope.builtin')
local function find_dotfiles()
	builtin.find_files {
		cwd = "~/dotfiles",
	}
end
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fd', find_dotfiles, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
