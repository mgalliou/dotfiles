local bufopts = { noremap = true, silent = true}
vim.keymap.set('n', '<leader>ca', ":CodeAction<CR>", bufopts)
