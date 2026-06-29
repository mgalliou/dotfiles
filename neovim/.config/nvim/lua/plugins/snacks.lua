---@type LazyPluginSpec[]
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			words = { enabled = true },
			indent = { enabled = true },
			gitbrowse = { enabled = true },
			notifier = { enabled = true },
			statuscolumn = { enabled = true },
			input = { enabled = true },
			picker = {
				enabled = true,
				layout = "telescope",
			},
			styles = {
				input = {
					border = "single",
					relative = "cursor",
					row = 1,
					col = 0,
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>/", function() Snacks.picker.grep({ hidden = true}) end, desc = "grep (Root Dir)", },
			{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History", },
			{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Find files (Root Dir))", },
			{ "<leader>ff", function() Snacks.picker.files({ hidden = true}) end, desc = "Find files (Root Dir))", },
			{ "<leader>fF", function() Snacks.picker.files({ cwd = vim.fn.expand "%:p:h", hidden = true }) end, desc = "Find files (Buffer Dir)", },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files (Root Dir)", },
			{ "<leader>fG", function() Snacks.picker.git_files({ root = false }) end, desc = "Find git files (Buffer Dir)", },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent files", },
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers", },
			{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers", },
			{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks", },
			{ "<leader>sM", function() Snacks.picker.man() end, desc = "Search man pages", },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Search helptags", },
			{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "Search Symbols", },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Search Symbols (Workspace)", },
			{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume last picker", },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.option("list", { name = "Whitespace characters" }):map("<leader>uW")
					Snacks.toggle
						.option(
							"conceallevel",
							{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
						)
						:map("<leader>uc")
					Snacks.toggle
						.option(
							"showtabline",
							{ off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
						)
						:map("<leader>uA")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle.diagnostics():map("<leader>ud")
					if vim.lsp.inlay_hint then
						Snacks.toggle.inlay_hints():map("<leader>uh")
					end
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.dim():map("<leader>uD")
					Snacks.toggle.animate():map("<leader>ua")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.scroll():map("<leader>uS")
					Snacks.toggle.profiler():map("<leader>dpp")
					Snacks.toggle.profiler_highlights():map("<leader>dph")
				end,
			})
		end,
	},
}
