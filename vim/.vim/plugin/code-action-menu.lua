local bufopts = { noremap = true, silent = true}
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.cmd.CodeActionMenu, bufopts)
