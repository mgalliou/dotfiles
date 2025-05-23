---@type LazyPluginSpec[]
return {
	{
		"mfussenegger/nvim-dap",
		enabled = false,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},
			-- TODO: plug "jbyuki/one-small-step-for-vimkind"
		},
		-- TODO: update configuration
		config = function()
			local dap = require("dap")

			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode-12", -- adjust as needed, must be absolute path
				name = "lldb",
			}
			dap.defaults.fallback.external_terminal = {
				command = "/usr/bin/terminator",
				args = { "-e" },
			}
			dap.defaults.fallback.force_external_terminal = true

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input({ "Path to executable: ", vim.fn.getcwd() .. "/", "file" })
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}
		end,
	},
}
