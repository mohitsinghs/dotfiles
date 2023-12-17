local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "tokyonight-storm"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.25

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

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
