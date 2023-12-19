local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "tokyonight-storm"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.25
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 24
config.default_workspace = "home"

local function get_font(name)
  return wezterm.font_with_fallback({
    name,
    { family = "SymbolsNFM", scale = 0.8 },
    "SegoeUIEmoji",
  })
end

config.font = get_font("OperatorMono-Book")
config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = get_font("OperatorMono-Medium"),
  },
  {
    intensity = "Bold",
    italic = true,
    font = get_font("OperatorMono-MediumItalic"),
  },
  {
    intensity = "Normal",
    italic = true,
    font = get_font("OperatorMono-BookItalic"),
  },
}

local colors = {
  bg_dark = "#1f2335",
  bg_light = "#292e42",
  fg = "#c0caf5",
  blue = "#7aa2f7",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
}

config.colors = {
  tab_bar = {
    background = colors.bg_light,
  },
}

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_frame = { font = get_font("OperatorMono-Book") }
config.command_palette_bg_color = colors.bg_light
config.command_palette_fg_color = colors.fg
config.command_palette_font_size = 12

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab)
  local title = tab_title(tab)
  local elements = {}

  local fg = colors.dark3
  local bg = colors.bg_light
  if tab.is_active then
    fg = colors.dark5
    table.insert(elements, { Attribute = { Intensity = "Bold" } })
  end
  table.insert(elements, { Foreground = { Color = fg } })
  table.insert(elements, { Background = { Color = bg } })
  table.insert(elements, { Text = " " .. title .. " " })
  return wezterm.format(elements)
end)

wezterm.on("update-status", function(window)
  local left = {}

  table.insert(left, { Foreground = { Color = colors.blue } })
  table.insert(left, { Background = { Color = colors.bg_dark } })
  table.insert(left, { Text = "▊ " .. window:active_workspace() .. " " })

  table.insert(left, { Foreground = { Color = colors.bg_dark } })
  table.insert(left, { Background = { Color = colors.bg_light } })
  table.insert(left, { Text = " " })

  window:set_left_status(wezterm.format(left))

  local right = {}

  table.insert(right, { Foreground = { Color = colors.bg_dark } })
  table.insert(right, { Background = { Color = colors.bg_light } })
  table.insert(right, { Text = "" })

  table.insert(right, { Foreground = { Color = colors.blue } })
  table.insert(right, { Background = { Color = colors.bg_dark } })
  table.insert(right, { Text = " " .. wezterm.strftime("%a %b %-d %-l:%M %p") .. " ▊" })

  window:set_right_status(wezterm.format(right))
end)

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "b", mods = "LEADER|CTRL", action = act.SendKey({ key = "b", mods = "CTRL" }) },
  { key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
  { key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "LeftArrow", mods = "META", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "META", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
  { key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "F11", mods = "", action = act.ToggleFullScreen },
}

return config
