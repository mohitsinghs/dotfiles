local M = {}

local themes = { "night", "moon", "storm", "day" }
vim.api.nvim_set_var("current_theme", 3)

M.switch_bg = function()
  if vim.opt.background:get() == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
end

M.cycle_theme = function()
  local current_index = vim.api.nvim_get_var("current_theme")
  local next_index
  if current_index >= 4 then
    next_index = 1
  else
    next_index = current_index + 1
  end
  if themes[next_index] then
    vim.cmd.colorscheme("tokyonight-" .. themes[next_index])
    vim.api.nvim_set_var("current_theme", next_index)
  end
end

return M
