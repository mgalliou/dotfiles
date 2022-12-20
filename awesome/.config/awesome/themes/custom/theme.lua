---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

--local mod = "dark"

local font_family   = "Input Nerd Font"
local font_size     = "10"

local t = {}

local gruvbox = {
    dark0_hard      =  "#1d2021",  -- [   ]  [   ]   
    dark0           =  "#282828",  -- [bg0]  [fg0]   
    dark0_soft      =  "#32302f",  -- [   ]  [   ]   
    dark1           =  "#3c3836",  -- [bg1]  [fg1]   
    dark2           =  "#504945",  -- [bg2]  [fg2]   
    dark3           =  "#665c54",  -- [bg3]  [fg3]   
    dark4           =  "#7c6f64",  -- [bg4]  [fg4]   

    gray_245        =  "#928374",  -- [gray] [   ]   
    gray_244        =  "#928374",  -- [   ] [gray]   

    light0_hard     =  "#f9f5d7",  -- [   ]  [   ]   
    light0          =  "#fbf1c7",  -- [fg0]  [bg0]   
    light0_soft     =  "#f2e5bc",  -- [   ]  [   ]   
    light1          =  "#ebdbb2",  -- [fg1]  [bg1]   
    light2          =  "#d5c4a1",  -- [fg2]  [bg2]   
    light3          =  "#bdae93",  -- [fg3]  [bg3]   
    light4          =  "#a89984",  -- [fg4]  [bg4]   

    bright_red      =  "#fb4934",  -- [red]   [  ]   
    bright_green    =  "#b8bb26",  -- [green] [  ]   
    bright_yellow   =  "#fabd2f",  -- [yellow][  ]   
    bright_blue     =  "#83a598",  -- [blue]  [  ]   
    bright_purple   =  "#d3869b",  -- [purple][  ]   
    bright_aqua     =  "#8ec07c",  -- [aqua]  [  ]   
    bright_orange   =  "#fe8019",  -- [orange][  ]   

    neutral_red     =  "#cc241d",  -- [   ]  [   ]   
    neutral_green   =  "#98971a",  -- [   ]  [   ]   
    neutral_yellow  =  "#d79921",  -- [   ]  [   ]   
    neutral_blue    =  "#458588",  -- [   ]  [   ]   
    neutral_purple  =  "#b16286",  -- [   ]  [   ]   
    neutral_aqua    =  "#689d6a",  -- [   ]  [   ]   
    neutral_orange  =  "#d65d0e",  -- [   ]  [   ]   

    faded_red       =  "#9d0006",  -- [   ]   [red]  
    faded_green     =  "#79740e",  -- [   ] [green]  
    faded_yellow    =  "#b57614",  -- [   ][yellow]  
    faded_blue      =  "#076678",  -- [   ]  [blue]  
    faded_purple    =  "#8f3f71",  -- [   ][purple]  
    faded_aqua      =  "#427b58",  -- [   ]  [aqua]  
    faded_orange    =  "#af3a03"   -- [   ][orange]  
}

--colorscheme
local cs = {
    bg            = gruvbox.dark0,
    fg            = gruvbox.light1,
    black         = gruvbox.dark0,
    white         = gruvbox.light0,
    gray          = gruvbox.gray_245,
    bright_gray   = gruvbox.light4,

    red           = gruvbox.bright_red,
    green         = gruvbox.bright_green,
    yellow        = gruvbox.bright_yellow,
    blue          = gruvbox.bright_blue  ,
    purple        = gruvbox.bright_purple,
    aqua          = gruvbox.bright_aqua  ,
    orange        = gruvbox.bright_orange,

    bright_red    = gruvbox.neutral_red,
    bright_green  = gruvbox.neutral_green,
    bright_yellow = gruvbox.neutral_yellow,
    bright_blue   = gruvbox.neutral_blue,
    bright_purple = gruvbox.neutral_purple,
    bright_aqua   = gruvbox.neutral_aqua,
    bright_orange = gruvbox.neutral_orange
}
t.cs = cs

t.font  = font_family .. " " .. font_size

t.bg_normal     = cs.bg
t.bg_focus      = cs.bright_blue
t.bg_urgent     = cs.red
t.bg_minimize   = cs.orange
t.bg_systray    = t.bg_normal

t.fg_normal     = cs.fg
t.fg_focus      = cs.black
t.fg_urgent     = cs.black
t.fg_minimize   = cs.black

t.useless_gap   = dpi(2)
t.border_width  = dpi(2)
t.border_normal = t.bg_normal
t.border_focus  = t.bg_focus
t.border_marked = "#91231c"
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
t.prompt_fg = cs.bg
t.prompt_bg = cs.bright_aqua
t.prompt_fg_cursor = cs.bg
t.prompt_bg_cursor = cs.fg
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
--t.taglist_bg_occupied = cs.bg
--t.taglist_fg_occupied = cs.fg
--t.taglist_fg_urgent = cs.black
--t.taglist_fg_focus = cs.black
-- tasklist_[bg|fg]_[focus|urgent]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
t.hotkeys_font             = font_family .. " " .. font_size
t.hotkeys_description_font = font_family .. " Italic " .. font_size
t.hotkeys_fg               = cs.white
t.hotkeys_bg               = cs.black
t.hotkeys_modifiers_fg     = cs.bright_gray

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

-- Generate taglist squares:
--[[
local taglist_square_size = dpi(4)
t.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, t.fg_normal
)
t.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, t.fg_normal
)
]]--

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
t.menu_submenu_icon = themes_path.."default/submenu.png"
t.menu_height = dpi(15)
t.menu_width  = dpi(100)

-- Define the image to load
t.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
t.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

t.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
t.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

t.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
t.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
t.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
t.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

t.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
t.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
t.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
t.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

t.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
t.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
t.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
t.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

t.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
t.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
t.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
t.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

t.wallpaper = "~/dotfiles/wallpaper/solidblack1px.jpg"

-- You can use your own layout icons like this:
t.layout_fairh = themes_path.."default/layouts/fairhw.png"
t.layout_fairv = themes_path.."default/layouts/fairvw.png"
t.layout_floating  = themes_path.."default/layouts/floatingw.png"
t.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
t.layout_max = themes_path.."default/layouts/maxw.png"
t.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
t.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
t.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
t.layout_tile = themes_path.."default/layouts/tilew.png"
t.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
t.layout_spiral  = themes_path.."default/layouts/spiralw.png"
t.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
t.layout_cornernw = themes_path.."default/layouts/cornernww.png"
t.layout_cornerne = themes_path.."default/layouts/cornernew.png"
t.layout_cornersw = themes_path.."default/layouts/cornersww.png"
t.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
t.awesome_icon = theme_assets.awesome_icon(
    t.menu_height, t.bg_focus, t.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
t.icon_theme = nil

local widgets = {
    mic = require("widgets/mic"),
}
t.mic = widgets.mic({
    timeout = 10,
    settings = function(self)
        if self.state == "muted" then
            self.widget:set_markup_silently("<b>muted</b>")
        else
            self.widget:set_markup_silently("<b>unmuted</b>")
        end
    end
})

return t

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
