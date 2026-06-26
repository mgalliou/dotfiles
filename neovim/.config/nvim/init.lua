_G.Utils = require("utils")

require("config.mappings")
require("config.lazy")
require("config.options")
require("config.autocmds")

local godot_file = vim.fs.find("project.godot", { upward = true })[1]
local is_godot_project = godot_file ~= nil
local godot_project_path = is_godot_project and vim.fs.dirname(godot_file) or ""

-- check if server is already running in godot project path
local is_server_running = godot_project_path ~= "" and vim.uv.fs_stat(godot_project_path .. "/server.pipe")
-- start server, if not already running
if is_godot_project and not is_server_running then
	vim.fn.serverstart(godot_project_path .. "/server.pipe")
end

vim.lsp.enable("gdscript")

if Utils.is_termux() then
	vim.lsp.enable("lua_ls")
end
