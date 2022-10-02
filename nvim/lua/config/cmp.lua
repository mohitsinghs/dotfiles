local cmp = require("cmp")
local icons = require("config.icons")

local function feed(key)
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "")
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.call("vsnip#available", 1) ~= 0 then
				feed("<Plug>(vsnip-jump-next)")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.call("vsnip#available", -1) ~= 0 then
				feed("<Plug>(vsnip-jump-prev)")
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "kind", "abbr" },
		format = function(_, vim_item)
			vim_item.kind = icons.icon_for(vim_item.kind)
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "vsnip", max_item_count = 5 },
		{ name = "path", max_item_count = 5 },
		{ name = "nvim_lsp_signature_help" },
	},
})
