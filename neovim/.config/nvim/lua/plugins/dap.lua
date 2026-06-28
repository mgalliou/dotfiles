---@type LazyPluginSpec[]
return {
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"jbyuki/one-small-step-for-vimkind",
		},
		-- stylua: ignore
		keys = {
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
			{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
			{ "<leader>dk", function() require("dap").up() end, desc = "Up" },
			{ "<leader>dL", function() require("osv").launch({ port = 8086 }) end, desc = "OSV Launch Server" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
			{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>ds", function() require("dap").session() end, desc = "Session" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		},
		config = function()
			for name, sign in pairs(Utils.debug_icons) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define("Dap" .. name, {
					text = sign[1] .. " ",
					texthl = sign[2] or "DiagnosticInfo",
					linehl = sign[3],
					numhl = sign[3],
				})
			end

			local dap = require("dap")
			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance (port 8086)",
				},
			}
			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		-- stylua: ignore
		keys = {
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Open DAP UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
		},
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local ui = require("dapui")

			ui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				ui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				ui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				ui.close()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = "mason.nvim",
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			automatic_installation = true,
			ensure_installed = { "codelldb" },
		},
	},
}
