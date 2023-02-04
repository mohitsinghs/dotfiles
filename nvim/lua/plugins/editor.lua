return {
  "tpope/vim-surround",
  { "numToStr/Comment.nvim", config = true },
  { "norcalli/nvim-colorizer.lua", config = true },
  {
    "tpope/vim-fugitive",
    config = function()
      require("core.keymaps").fugitive()
    end,
  },
  {
    "tanvirtin/vgit.nvim",
    config = function()
      require("vgit").setup()
      require("core.keymaps").vgit()
    end,
  },
}
