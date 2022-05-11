local telescope = require("telescope")
telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		layout_config = {
			prompt_position = "top",
		},
	},
})
telescope.load_extension("fzf")
