local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Bold" })
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.color_scheme = "Gruvbox dark, medium (base16)"

local active_fg = "#ebdbb2"
local inactive_fg = "#a89984"
local active_bg = "#282828"
local inactive_bg = "#333333"
config.colors = {
	tab_bar = {
		active_tab = {
			fg_color = active_fg,
			bg_color = active_bg,
		},
		inactive_tab = {
			fg_color = inactive_fg,
			bg_color = inactive_bg,
		},
		inactive_tab_hover = {
			fg_color = inactive_fg,
			bg_color = active_bg,
		},
		new_tab = {
			fg_color = inactive_fg,
			bg_color = inactive_bg,
		},
		new_tab_hover = {
			fg_color = inactive_fg,
			bg_color = active_bg,
		},
	},
}

return config
