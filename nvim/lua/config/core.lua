local config = {
	mouse = "a",
	swapfile = false,
	number = true,
	relativenumber = true,
	shortmess = { a = true, I = true, F = true, W = true, c = true },
	termguicolors = true,
	tabstop = 2,
	shiftwidth = 2,
	softtabstop = 2,
	expandtab = true,
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
vim.cmd("color tokyonight")

return config
