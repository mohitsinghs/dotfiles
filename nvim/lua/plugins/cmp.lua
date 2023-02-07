local icons = require("core.icons")

local function feed(key)
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "")
end

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",
  },
  opts = function()
    local cmp = require("cmp")
    return {
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
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feed("<Plug>(vsnip-expand-or-jump)")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#available"](-1) == 1 then
            feed("<Plug>(vsnip-jump-prev)")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
          if vim_item.kind == "Color" and entry.completion_item.documentation then
            local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
            if r then
              local color = string.format("%02x%02x%02x", r, g, b)
              local group = "Tw_" .. color
              if vim.fn.hlID(group) < 1 then
                vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
              end
              vim_item.kind = "■"
              vim_item.kind_hl_group = group
              return vim_item
            end
          end
          vim_item.kind = icons.icon_for(vim_item.kind)
          return vim_item
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 10 },
        { name = "vsnip", max_item_count = 5 },
        { name = "path", max_item_count = 5 },
        { name = "nvim_lsp_signature_help" },
      }, {
        name = "buffer",
      }),
    }
  end,
}
