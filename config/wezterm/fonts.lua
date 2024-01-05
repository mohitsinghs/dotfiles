local wezterm = require("wezterm")

local function get_font(name)
  return wezterm.font_with_fallback({
    name,
    { family = "Symbols Nerd Font" },
    "Segoe UI Emoji",
  })
end

return {
  Bold = get_font("OperatorMono-Medium"),
  BoldI = get_font("OperatorMono-MediumItalic"),
  Book = get_font("OperatorMono-Book"),
  BookI = get_font("OperatorMono-BookItalic"),
}
