local telescope = require("telescope")
telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		layout_config = {
			prompt_position = "top",
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
