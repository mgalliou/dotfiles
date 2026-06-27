---@type LazyPluginSpec[]
return {
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gread",
			"Gwrite",
			"Grep",
			"Glgrep",
			"Gmove",
			"GRename",
			"GDelete",
			"GRemove",
			"GBrowse",
		},
	},
	{
		"nanotee/zoxide.vim",
		cmd = {
			"Z",
			"Lz",
			"Tz",
			"Zi",
			"Lzi",
			"Tzi",
		},
	},
}
