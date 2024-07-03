local M = {}

local themes = { "night", "moon", "storm" }
vim.api.nvim_set_var("current_theme", 3)

M.cycle_theme = function()
  local current_index = vim.api.nvim_get_var("current_theme")
  local next_index
  if current_index >= 3 then
    next_index = 1
  else
    next_index = current_index + 1
  end
  if themes[next_index] then
    M.set_theme(themes[current_index])
    vim.api.nvim_set_var("current_theme", next_index)
  end
end

M.set_theme = function(theme)
  require("tokyonight").setup({
    on_highlights = require("core.highlights").on_highlights,
    style = theme,
    plugins = {
      auto = true,
    },
    styles = {
      sidebars = "normal",
    },
  })
  vim.cmd.colorscheme("tokyonight")
end

return M
