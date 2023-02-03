vim.keymap.set('n', "<leader>rl", "<CMD>so $MYVIMRC", { desc = "Reload configuration" })
vim.keymap.set('n', "<leader>ws", "m`:%s/\\s\\+$//<CR>:let @/=''<CR>``:w<CR>", { desc = "Remove trailing whitespaces" })
vim.keymap.set('n', "<leader>lst", "<CMD> set list!<CR>", { desc = "Toggle list chars" })
vim.keymap.set('n', "<leader>sc", "<CMD>set spell!<CR>", { desc = "Toggle spellcheck" })	
-- TODO: add "save file as root" mapping, or find another (better) solution
-- TODO: add toggle line number map
