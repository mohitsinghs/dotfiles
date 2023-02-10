local colors = require("core.colors")

local function set_link(source, target)
  vim.api.nvim_set_hl(0, source, { link = target })
end

local function set_hl(source, fg, bg)
  vim.api.nvim_set_hl(0, source, { bg = bg, fg = fg })
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
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
      enable_diagnostics = false,
      enable_modified_markers = false,
      default_component_configs = {
        indent = {
          padding = 0,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        git_status = {
          symbols = {
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
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

    vim.cmd([[nnoremap \ :Neotree toggle<cr>]])
    set_hl("NeoTreeTabActive", colors.fg, colors.bg_dark)
    set_hl("NeoTreeTabInactive", colors.dark5, colors.bg_light)
    set_link("NeoTreeDirectoryIcon", "NvimTreeFolderIcon")
    set_link("NeoTreeDirectoryName", "NvimTreeFolderName")
    set_link("NeoTreeSymbolicLinkTarget", "NvimTreeSymlink")
    set_link("NeoTreeRootName", "NvimTreeRootFolder")
    set_link("NeoTreeDirectoryName", "NvimTreeOpenedFolderName")
    set_link("NeoTreeFileNameOpened", "NvimTreeOpenedFile")
    set_link("NeoTreeIndentMarker", "NvimTreeIndentMarker")
    for _, type in ipairs({ "Untracked", "Unstaged", "Modified", "Conflict" }) do
      set_link("NeoTreeGit" .. type, "NvimTreeGitDirty")
    end
    set_link("NeoTreeGitDeleted", "NvimTreeGitDeleted")
  end,
}
