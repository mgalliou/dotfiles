---@type LazyPluginSpec[]
return {
	{
		"dag/vim-fish",
		ft = "fish",
	},
	{
		"tmux-plugins/vim-tmux",
		ft = "tmux",
	},
	{
		"leafgarland/typescript-vim",
		ft = "typescript",
	},
	{
		"pearofducks/ansible-vim",
		enabled = false,
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
		---@module "render.md"
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
			completetions = {
				lsp = {
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = function()
					return require("render-markdown.state").enabled
				end,
				set = function(enabled)
					local m = require("render-markdown")
					if enabled then
						m.enable()
					else
						m.disable()
					end
				end,
			}):map("<leader>um")
		end,
	},
}
