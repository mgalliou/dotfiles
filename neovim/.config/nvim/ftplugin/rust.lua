local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set({ "n", "i" }, "grd", function()
	vim.cmd.RustLsp("relatedDiagnostics")
end, { buffer = bufnr, desc = "Go to related diagnostics" })

vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, { buffer = bufnr, desc = "Hover" })

vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction")
end, { buffer = bufnr, desc = "Code actions" })

vim.keymap.set("n", "<leader>gC", function()
	vim.cmd.RustLsp("openCargo")
end, { buffer = bufnr, desc = "Open Cargo.toml" })

vim.keymap.set("n", "<leader>gpm", function()
	vim.cmd.RustLsp("parentModule")
end, { buffer = bufnr, desc = "Go to parent module" })

vim.keymap.set("n", "J", function()
	vim.cmd.RustLsp("joinLines")
end, { buffer = bufnr, desc = "Join lines" })
