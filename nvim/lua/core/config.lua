local config = {
  mouse = "a",
  swapfile = false,
  number = true,
  relativenumber = true,
  shortmess = "IFcWas",
  termguicolors = true,
  cmdheight = 0,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
  fileencoding = "utf-8",
  updatetime = 250,
  signcolumn = "yes",
  incsearch = false,
  wildignore = "*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc",
  list = true,
  listchars = { tab = "→ ", space = "·", trail = "·" },
  splitright = true,
  splitbelow = true,
}

for key, val in pairs(config) do
  vim.opt[key] = val
end

vim.opt.clipboard:append({ "unnamedplus" })

require("core.keymaps").core()

return config
