local telescope = require("telescope")

telescope.load_extension("fzf")
require("vgit").setup()
require("fidget").setup()
require("colorizer").setup()
require("lualine").setup({
	options = {
		theme = "tokyonight",
		globalstatus = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	extensions = { "fugitive" },
	sections = {
		lualine_b = { { "FugitiveHead", icon = "" }, "diff", "diagnostics" },
	},
})
