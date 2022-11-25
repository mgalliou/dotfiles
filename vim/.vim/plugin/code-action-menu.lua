local bufopts = { noremap = true, silent = true}

vim.g.code_action_menu_show_diff = false
vim.g.code_action_menu_show_details = false

vim.keymap.set({'n', 'v'}, '<leader>ca', vim.cmd.CodeActionMenu, bufopts)
