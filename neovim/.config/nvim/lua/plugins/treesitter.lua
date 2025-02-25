return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			auto_install = { enable = true },
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = { enable = true },
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"mtrajano/tssorter.nvim",
		version = "*",
		opts = {
			-- leave empty for the default config or define your own sortables in here. They will add, rather than
			-- replace, the defaults for the given filetype
			sortables = {
				gitconfig = {
					section_header = {
						node = "section",
					},
					name = {
						node = "variable",
					},
				},
			},
		},
	},
}
