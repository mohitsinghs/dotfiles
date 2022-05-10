local t_lsp = require("telescope.builtin.lsp")
local entry_display = require("telescope.pickers.entry_display")
local icons = require("icons")

local M = {}

local lsp_type_highlight = {
	["Class"] = "TelescopeResultsClass",
	["Constant"] = "TelescopeResultsConstant",
	["Field"] = "TelescopeResultsField",
	["Function"] = "TelescopeResultsFunction",
	["Method"] = "TelescopeResultsMethod",
	["Property"] = "TelescopeResultsOperator",
	["Struct"] = "TelescopeResultsStruct",
	["Variable"] = "TelescopeResultsVariable",
}

local function gen_from_lsp_symbols()
	local bufnr = vim.api.nvim_get_current_buf()
	local display_items = {
		{ width = 3 }, -- symbol icon
		{ width = 25 }, -- symbol name
		{ width = 8 }, -- symbol type
		{ remaining = true }, -- content preview
	}

	local hl_border = "TelescopeBorder"
	local hl_dim = "TelescopeResultsComment"

	local displayer = entry_display.create({
		separator = " ",
		hl_chars = { ["["] = hl_border, ["]"] = hl_border },
		items = display_items,
	})

	local make_display = function(entry)
		local msg = vim.trim(vim.api.nvim_buf_get_lines(bufnr, entry.lnum - 1, entry.lnum, false)[1] or "")
		local type_highlight = lsp_type_highlight
		local icon = icons.icon_for(entry.symbol_type)
		local display_columns = {
			{ icon, type_highlight[entry.symbol_type], type_highlight[entry.symbol_type] },
			entry.symbol_name,
			{ entry.symbol_type:lower(), hl_dim, hl_dim },
			msg,
		}

		return displayer(display_columns)
	end

	return function(entry)
		local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)
		local symbol_msg = entry.text
		local symbol_type, symbol_name = symbol_msg:match("%[(.+)%]%s+(.*)")

		local ordinal = symbol_name .. " " .. (symbol_type or "unknown")
		return {
			valid = true,

			value = entry,
			ordinal = ordinal,
			display = make_display,

			filename = filename,
			lnum = entry.lnum,
			col = entry.col,
			symbol_name = symbol_name,
			symbol_type = symbol_type,
			start = entry.start,
			finish = entry.finish,
		}
	end
end

M.list = function()
	t_lsp.document_symbols({
		entry_maker = gen_from_lsp_symbols(),
	})
end

return M
