local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor position",
	group = augroup("restore_cursor"),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	desc = "Auto-create parent directories",
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("yank_highlight"),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable wrap and spell for prose",
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable auto-comment on newline",
	group = augroup("disable_auto_comment"),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Close some filetypes with <q>",
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"git",
		"help",
		"man",
		"notify",
		"qf",
		"scratch",
		"startuptime",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				if vim.fn.winnr("$") > 1 then
					vim.cmd("close")
				else
					vim.cmd("quit")
				end
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buf = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

local dyn_smartcase_group = augroup("dynamic_smartcase")
vim.api.nvim_create_autocmd("CmdlineEnter", {
	desc = "Disable smartcase in cmdline",
	group = dyn_smartcase_group,
	callback = function()
		vim.opt.smartcase = false
	end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
	desc = "Re-enable smartcase after cmdline",
	group = dyn_smartcase_group,
	callback = function()
		vim.opt.smartcase = true
	end,
})
