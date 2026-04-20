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
	},
	{
		"towolf/vim-helm",
		ft = "helm",
	},
	{
		"vim-scripts/tf2.vim",
		ft = "cfg",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
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
