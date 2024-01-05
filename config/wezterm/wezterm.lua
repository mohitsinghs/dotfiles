local wezterm = require("wezterm")
local config = wezterm.config_builder()
local keys = require("keymaps")
local colors = require("colors")
local fonts = require("fonts")

require("status")

config.color_scheme = "tokyonight-storm"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 11
config.line_height = 1.25
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 24
config.default_workspace = "home"
config.front_end = "WebGpu"

config.font = fonts.Book
config.font_rules = {
  { intensity = "Bold", italic = false, font = fonts.Bold },
  { intensity = "Bold", italic = true, font = fonts.BoldI },
  { intensity = "Normal", italic = true, font = fonts.BookI },
  { intensity = "Half", italic = true, font = fonts.BoldI },
  { intensity = "Half", italic = false, font = fonts.Bold },
}

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_frame = { font = fonts.Book }

config.colors = { tab_bar = { background = colors.bg } }
config.command_palette_bg_color = colors.bg
config.command_palette_fg_color = colors.blue
config.command_palette_font_size = 12

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 5000 }
config.keys = keys

return config
