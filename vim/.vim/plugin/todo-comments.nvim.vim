if tools#PluginIsLoaded("todo-comments.nvim")
	" needs to be loaded last to not be overwritten by colorscheme
	lua require("todo-comments").setup{}
end
