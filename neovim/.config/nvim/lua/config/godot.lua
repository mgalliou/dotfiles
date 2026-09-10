local M = {}

function M.setup()
	vim.lsp.enable("gdscript")

	local godot_file = vim.fs.find("project.godot", { upward = true })[1]
	if not godot_file then
		return
	end

	local project_root = vim.fs.dirname(godot_file)
	local socket = vim.fs.normalize(project_root .. "/server.pipe")
	local running = vim.tbl_contains(vim.fn.serverlist(), socket)
	local stat = vim.uv.fs_stat(socket)

	if not running and stat then
		if stat.type == "socket" then
			local removed, err = vim.uv.fs_unlink(socket)
			if not removed then
				vim.notify("Could not remove stale Godot socket: " .. err, vim.log.levels.WARN)
			end
		else
			vim.notify("Godot socket path is not a socket: " .. socket, vim.log.levels.WARN)
		end
	end

	if not vim.tbl_contains(vim.fn.serverlist(), socket) and not vim.uv.fs_stat(socket) then
		local ok, err = pcall(vim.fn.serverstart, socket)
		if not ok then
			vim.notify("Could not start Godot socket: " .. err, vim.log.levels.WARN)
		end
	end
end

return M
