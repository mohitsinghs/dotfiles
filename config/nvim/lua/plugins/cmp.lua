local icons = require("core.icons")

local function get_icon_and_hl(ctx)
  if ctx.source_name == "Path" then
    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
    if dev_icon then
      return dev_icon .. " ", dev_hl
    end
  end
  return icons.icon_for(ctx.kind), ctx.kind_hl
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "folke/lazydev.nvim",
    },
    version = "1.*",
    opts = {
      keymap = { preset = "super-tab" },
      appearance = { kind_icons = icons },
      completion = {
        documentation = { auto_show = true },
        trigger = { show_on_keyword = true },
        menu = {
          draw = {
            columns = { { "kind_icon", "label" } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon, _ = get_icon_and_hl(ctx)
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local _, hl = get_icon_and_hl(ctx)
                  return hl
                end,
              },
            },
          },
        },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
        lua = { inherit_defaults = true, "lazydev" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}
