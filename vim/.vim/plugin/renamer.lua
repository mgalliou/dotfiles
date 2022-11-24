local renamer = require("renamer")

local function rename()
	return renamer.rename {
		empty = true
	}
end

renamer.setup {
	border_chars = require("tools").borderchars,
}
vim.keymap.set('i', '<F2>', rename, { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>rn', rename, { noremap = true, silent = true })
