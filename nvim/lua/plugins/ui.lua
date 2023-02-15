return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        on_highlights = require("core.highlights").on_highlights,
      })
      vim.cmd("color tokyonight")
    end,
    lazy = true,
  },
  {
    "j-hui/fidget.nvim",
    event = "BufReadPost",
    opts = {
      text = { spinner = "dots" },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = { deafult = true, strict = true },
    lazy = true,
  },
}
