vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- location list
map("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)

	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)

	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

-- diagnostics
local diag = vim.diagnostic

map("n", "<leader>uF", diag.open_float, { desc = "Diagnostic float" })
map("n", "[d", function()
	diag.jump({
		count = -1,
		float = true,
	})
end, { desc = "Previous Diagnostic" })
map("n", "]d", function()
	diag.jump({
		count = 1,
		float = true,
	})
end, { desc = "Next Diagnostic" })

-- map("n", "<leader>rl", "<CMD>so $MYVIMRC", { desc = "Reload configuration" })
-- map("n", "<leader>ws", "m`:%s/\\s\\+$//<CR>:let @/=''<CR>``:w<CR>", { desc = "Remove trailing whitespaces" })

-- TODO: add "save file as root" mapping, or find another (better) solution
