local langs = {
	"bash",
	"css",
	"dockerfile",
	"go",
	"gomod",
	"gowork",
	"graphql",
	"help",
	"html",
	"http",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"jsonc",
	"lua",
	"make",
	"markdown",
	"python",
	"regex",
	"rust",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"yaml",
}

local config = {
	ensure_installed = langs,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true,
		},
		highlight_current_scope = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup(config)
			require("treesitter-context").setup()
		end,
	},
}
