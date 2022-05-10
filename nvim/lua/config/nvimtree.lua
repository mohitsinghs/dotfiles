require("nvim-tree").setup({
	update_cwd = true,
	disable_netrw = true,
	hijack_cursor = true,
	diagnostics = {
		enable = false,
	},
	git = {
		enable = false,
	},
	view = {
		hide_root_folder = true,
	},
	renderer = {
		icons = {
			webdev_colors = false,
		},
	},
})

vim.g.nvim_tree_icons = {
	folder = {
		arrow_open = "",
		arrow_closed = "",
	},
}
local colors = require("config.colors")
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.blue })
