local telescope = require("telescope")

telescope.load_extension("fzf")
require("vgit").setup()
require("lualine").setup({
	options = {
		theme = "tokyonight",
		globalstatus = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
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
