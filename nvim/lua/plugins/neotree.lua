return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "\\", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("neo-tree").setup({
      source_selector = {
        winbar = true,
        tab_labels = {
          filesystem = " File",
          buffers = "  Buffers ",
          git_status = " Git",
        },
        content_layout = "center",
        separator = { left = "", right = "" },
      },
      close_if_last_window = true,
      add_blank_line_at_top = true,
      enable_diagnostics = false,
      default_component_configs = {
        indent = {
          padding = 1,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
        modified = {
          symbol = "",
        },
        git_status = {
          symbols = {
            added = "A",
            deleted = "D",
            modified = "M",
            renamed = "R",
            untracked = "U",
            ignored = "",
            unstaged = "",
            staged = "S",
            conflict = "C",
          },
        },
        name = {
          use_git_status_colors = false,
        },
      },
      window = {
        width = 40,
        mappings = {
          ["e"] = function()
            vim.api.nvim_exec("Neotree focus filesystem left", true)
          end,
          ["b"] = function()
            vim.api.nvim_exec("Neotree focus buffers left", true)
          end,
          ["g"] = function()
            vim.api.nvim_exec("Neotree focus git_status left", true)
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = true,
        group_empty_dirs = false,
        use_libuv_file_watcher = true,
      },
    })
  end,
}
