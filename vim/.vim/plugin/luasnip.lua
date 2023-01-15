require("luasnip.loaders.from_vscode").lazy_load()
vim.keymap.set('i', "<tab>", function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
	  end, {expr = true, silent = true})
vim.keymap.set('s', "<tab>", function() return require("luasnip").jumpable(1) end, nil)
vim.keymap.set({'i', 's'}, "<s-tab>", function() return require("luasnip").jumpable(-1) end, nil)
