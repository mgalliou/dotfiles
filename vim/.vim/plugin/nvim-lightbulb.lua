require('nvim-lightbulb').setup {
	sign = {
		enabled = false,
	},
	virtual_text = {
		enabled = true,
		hl_mode = "combine",
	},
	status_text = {
		enabled = true,
	},
	autocmd = {
		enabled = true,
		events = { "CursorHold", "CursorHoldI" }
	}
}
