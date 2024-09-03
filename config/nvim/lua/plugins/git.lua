return {
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    init = function()
      require("core.keymaps").fugitive()
    end,
    lazy = true,
  },
  {
    "tanvirtin/vgit.nvim",
    event = "BufReadPre",
    init = function()
      require("core.keymaps").vgit()
    end,
    config = true,
    lazy = true,
  },
}
