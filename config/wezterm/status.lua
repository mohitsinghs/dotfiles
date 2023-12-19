local wezterm = require("wezterm")
local colors = require("colors")

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
