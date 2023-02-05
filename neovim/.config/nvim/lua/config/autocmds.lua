vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("disable_auto_comment", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove('r')
		vim.opt_local.formatoptions:remove('o')
	end
})

local dyn_smartcase_group = vim.api.nvim_create_augroup("dynamic_smartcase", { clear = true })
vim.api.nvim_create_autocmd("CmdLineEnter", {
	group = dyn_smartcase_group,
	callback = function()
		vim.opt.smartcase = false
	end
})
vim.api.nvim_create_autocmd("CmdLineLeave", {
	group = dyn_smartcase_group,
	callback = function()
		vim.opt.smartcase = true
	end
})
