---@type LazyPluginSpec[]
return {
	{
		"tmux-plugins/vim-tmux",
		ft = "tmux",
	},
	{
		"pearofducks/ansible-vim",
		init = function()
			vim.filetype.add({
				pattern = {
					[".*/playbooks?/.*%.ya?ml"] = "ansible",
				},
			})
		end,
		config = function()
			require("ansible").setup()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "ansible",
				callback = function(args)
					vim.keymap.set({ "n", "x" }, "grR", function()
						local tasks = vim.fn.expand("<cfile>") .. "/tasks/main.yml"
						local role = vim.fn.findfile(tasks, vim.fn.expand("%:p:h") .. "/../roles")
						if role == "" then
							return vim.notify(tasks .. " not found", vim.log.levels.WARN)
						end
						vim.cmd.edit(vim.fn.fnameescape(role --[[@as string]]))
					end, { buffer = args.buf, desc = "Go to Ansible role" })
				end,
			})
		end,
	},
	{
		"towolf/vim-helm",
	},
	{
		"vim-scripts/tf2.vim",
		ft = "cfg",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		---@type render.md.UserConfig
		opts = {
			code = {
				width = "block",
				min_width = 80,
				right_pad = 1,
				sign = false,
			},
			heading = {
				width = "block",
				min_width = 80,
				right_pad = 1,
				sign = false,
			},
			completions = {
				blink = {
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = require("render-markdown").get,
				set = require("render-markdown").set,
			}):map("<leader>um")
		end,
	},
}
