local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set({ "n", "i" }, "]D", function()
	vim.cmd.RustLsp("relatedDiagnostics")
end, { noremap = true, silent = true, buffer = bufnr, desc = "Go to related diagnostics" })

vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })

vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction")
end, { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })

vim.keymap.set("n", "<leader>gC", function()
	vim.cmd.RustLsp("openCargo")
end, { noremap = true, silent = true, buffer = bufnr, desc = "Open Cargo.toml" })

vim.keymap.set("n", "<leader>gpm", function()
	vim.cmd.RustLsp("parentModule")
end, { noremap = true, silent = true, buffer = bufnr, desc = "Parent module" })

vim.keymap.set("n", "J", function()
	vim.cmd.RustLsp("joinLines")
end, { noremap = true, silent = true, buffer = bufnr })
