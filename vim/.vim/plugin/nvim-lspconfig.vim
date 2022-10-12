if tools#PluginIsLoaded("nvim-lspconfig")
	lua require'lspconfig'.vimls.setup{}
	lua require'lspconfig'.solargraph.setup{}
	lua require'lspconfig'.sumneko_lua.setup{}
	lua require'lspconfig'.ccls.setup{}
endif
