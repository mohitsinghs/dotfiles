vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.shortmess = { a = true, I = true, F = true, W = true, c = true }
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.foldenable = true
vim.opt.fileencoding = "utf-8"
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.wildignore = "*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc"
vim.opt.list = true
vim.opt.listchars = { tab = "··", trail = "·" }
vim.opt.guifont = "Operator Mono Book:h10"

vim.cmd("hi Comment cterm=italic gui=italic")
vim.cmd("color tokyonight")
vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")
