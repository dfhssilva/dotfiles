---------------------------
-- Nord minimal theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local theme_path = gfs.get_themes_dir()

-- inherit default theme
local theme = dofile(theme_path .. "default/theme.lua")
-- load vector assets' generators for this theme

--local wibar = require("wibar")
theme.nord0 = "#2E3440"
theme.nord1 = "#3B4252"
theme.nord2 = "#434C5E"
theme.nord3 = "#4C566A"
theme.nord4 = "#D8DEE9"
theme.nord5 = "#E5E9F0"
theme.nord6 = "#ECEFF4"
theme.nord7 = "#8FBCBB"
theme.nord8 = "#88C0D0"
theme.nord9 = "#81A1C1"
theme.nord10 = "#5E81AC"
theme.nord11 = "#BF616A"
theme.nord12 = "#D08770"
theme.nord13 = "#EBCB8B"
theme.nord14 = "#A3BE8C"
theme.nord15 = "#B48EAD"

theme.font = "Roboto 10"
theme.transparent = "#00000000"

theme.bg_normal = theme.nord0
theme.bg_focus = theme.nord1
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.nord2
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.nord4
theme.fg_focus = theme.nord9
theme.fg_urgent = theme.nord11
theme.fg_minimize = theme.fg_normal

theme.useless_gap = dpi(2)
theme.border_width = dpi(3)
theme.border_focus = theme.nord9
theme.border_normal = theme.nord0
theme.border_marked = theme.nord11

theme.tasklist_bg_focus = theme.nord0
theme.tasklist_icon_size = dpi(2)
theme.tasklist_plain_task_name = true

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

theme.wallpaper = "~/.config/awesome/wallpaper.jpg"
theme.background = theme.nord0

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.taglist_spacing = dpi(4)
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_focus = theme.nord13
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.nord14
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = theme.nord9
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_fg_urgent = theme.nord11

return theme
