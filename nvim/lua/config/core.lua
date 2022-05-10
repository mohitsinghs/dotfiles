local config = {
	mouse = "a",
	swapfile = false,
	number = true,
	relativenumber = true,
	laststatus = 2,
	shortmess = { a = true, I = true, F = true, W = true, c = true },
	termguicolors = true,
	tabstop = 2,
	shiftwidth = 2,
	softtabstop = 2,
	expandtab = true,
	foldenable = true,
	fileencoding = "utf-8",
	updatetime = 250,
	signcolumn = "yes",
	wildignore = "*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc",
	list = true,
	listchars = { tab = "··", trail = "·" },
	guifont = "Operator Mono Book:h10",
}

for key, val in pairs(config) do
	vim.opt[key] = val
end

vim.opt.clipboard:append({ "unnamedplus" })
vim.cmd("hi Comment cterm=italic gui=italic")
vim.cmd("color tokyonight")
vim.cmd("set t_ZH=[3m")
vim.cmd("set t_ZR=[23m")

return config
