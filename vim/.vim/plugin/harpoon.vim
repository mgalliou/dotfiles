if tools#PluginIsLoaded("harpoon")
	nnoremap <leader>Ha <CMD>lua require("harpoon.mark").add_file()<CR>
	nnoremap <leader>Ht <CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>
	nnoremap <leader><leader>h <CMD>lua require("harpoon.ui").nav_file(vim.v.count1)<CR>
endif
