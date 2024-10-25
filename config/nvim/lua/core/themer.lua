local M = {}

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
