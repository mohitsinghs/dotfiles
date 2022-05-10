local colors = require("config.colors")

local mode_color = {
	n = colors.cyan,
	i = colors.green,
	v = colors.magenta,
	c = colors.red,
	no = colors.magenta,
	s = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.magenta,
	Rv = colors.magenta,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local function get_head()
	return " " .. vim.fn.FugitiveHead()
end

local function get_cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

local start_left = {
	function()
		return "▊"
	end,
	color = { fg = colors.blue, bg = colors.bg_dark },
	padding = { left = 0, right = 0 },
}

local end_left = {
	function()
		return ""
	end,
	color = { fg = colors.bg_dark, bg = colors.bg_light },
	padding = 0,
}

local ext_fugitive = {
	sections = {
		lualine_c = {
			start_left,
			{ get_head, color = { fg = colors.magenta, bg = colors.bg_dark } },
			end_left,
		},
		lualine_x = { { "location", icon = "" } },
	},
	filetypes = { "fugitive" },
}

local ext_nvimtree = {
	sections = {
		lualine_c = {
			start_left,
			{ get_cwd, color = { fg = colors.cyan, bg = colors.bg_dark } },
			end_left,
		},
	},
	filetypes = { "NvimTree" },
}

local config = {
	options = {
		globalstatus = true,
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.dark5, bg = colors.bg_light } },
			inactive = { c = { fg = colors.dark5, bg = colors.bg_dark } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	extensions = {
		ext_fugitive,
		ext_nvimtree,
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 0, right = 0 },
})

ins_left({
	function()
		return require("lualine.utils.mode").get_mode()
	end,
	color = function()
		return { fg = mode_color[vim.fn.mode()], bg = colors.bg_dark }
	end,
	padding = { left = 1, right = 1 },
})

ins_left({
	function()
		return ""
	end,
	color = { fg = colors.bg_dark },
	padding = 0,
})

ins_left({
	"filetype",
	fmt = string.upper,
	icons_enabled = true,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
})

ins_left({
	icon = "",
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({ "location", icon = "" })

ins_left({ "progress", color = { gui = "bold" }, padding = 0 })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = "  ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
})

ins_left({
	function()
		return "%="
	end,
})

ins_right({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		local names = " "
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
				if #names > 1 then
					names = names .. ", "
				end
				names = names .. client.name
			end
		end
		return names
	end,
	icon = "",
})

ins_right({
	"o:encoding",
	fmt = string.upper,
	cond = conditions.hide_in_width,
})

ins_right({
	"fileformat",
	fmt = string.upper,
	padding = {
		right = 2,
		left = 1,
	},
})

ins_right({
	function()
		return ""
	end,
	color = { fg = colors.bg_dark },
	cond = conditions.check_git_workspace,
	padding = 0,
})

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.purple, gui = "bold", bg = colors.bg_dark },
})

ins_right({
	"diff",
	symbols = { added = "  ", modified = "  ", removed = "  " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = 0,
})

require("lualine").setup(config)
