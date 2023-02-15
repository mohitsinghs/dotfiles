local options = {
  defaults = {
    prompt_prefix = "   ",
    layout_config = {
      prompt_position = "top",
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
}

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    init = function()
      require("core.keymaps").telescope()
    end,
    config = function()
      local telescope = require("telescope")
      telescope.setup(options)
      telescope.load_extension("fzf")
    end,
    lazy = true,
  },
}
