local wezterm = require("wezterm")
local act = wezterm.action

return {
  { key = "b", mods = "LEADER|CTRL", action = act.SendKey({ key = "b", mods = "CTRL" }) },
  { key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
  { key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "LeftArrow", mods = "META", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "META", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
  { key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "F11", mods = "", action = act.ToggleFullScreen },
}
