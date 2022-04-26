local telescope = require("telescope")

telescope.load_extension("fzf")
telescope.load_extension("repo")
require("vgit").setup()
require("lualine").setup({
	options = {
		theme = "tokyonight",
		globalstatus = true,
	},
	extensions = { "fugitive" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "FugitiveHead", icon = "" }, "diff", "diagnostics" },
		lualine_c = {
			"filename",
			{ "lsp_progress", spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" } },
		},
	},
})
