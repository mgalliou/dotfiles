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
		"preservim/vim-markdown",
		init = function()
			vim.g.vim_markdown_new_list_indent = 2
		end,
	},
}
