return {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd("color tokyonight")
    end,
  },
  { "j-hui/fidget.nvim", opts = { text = { spinner = "dots" } }, config = true },
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
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
