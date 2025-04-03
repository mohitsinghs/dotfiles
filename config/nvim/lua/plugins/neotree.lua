return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "mohitsinghs/repo.nvim",
  },
  keys = {
    { "\\", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("neo-tree").setup({
      sources = {
        "filesystem",
        "repo",
        "buffers",
      },
      source_selector = {
        truncation_character = "",
        winbar = true,
        sources = {
          { source = "filesystem", display_name = "  Files" },
          { source = "repo", display_name = "  Repos" },
          { source = "buffers", display_name = "  Buffers" },
        },
        content_layout = "center",
        separator = { left = "", right = "" },
      },
      close_if_last_window = true,
      hide_root_node = true,
      enable_diagnostics = false,
      default_component_configs = {
        indent = {
          padding = 1,
        },
        icon = {
          folder_empty_open = "",
          folder_closed = "",
          folder_open = "",
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
            vim.api.nvim_exec2("Neotree focus filesystem", { output = true })
          end,
          ["b"] = function()
            vim.api.nvim_exec2("Neotree focus buffers", { output = true })
          end,
          ["R"] = function()
            vim.api.nvim_exec2("Neotree focus repo", { output = true })
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        group_empty_dirs = false,
        use_libuv_file_watcher = true,
      },
    })
  end,
}
