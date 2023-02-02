local M = {}

vim.g.mapleader = ","

local function map_normal(key, cmd)
  vim.api.nvim_set_keymap("n", key, ":<C-u>" .. cmd .. "<cr>", { noremap = true, silent = true })
end

M.core = function()
  -- Write and quit
  map_normal("<leader>q", "q")
  map_normal("<leader>w", "w")
  map_normal("<leader>ws", "noa w")
  map_normal("<leader>wa", "wa")
  map_normal("<leader>wtf", "w !sudo tee >/dev/null %")

  -- Buffer navigation
  map_normal("<F1>", "bd")
  map_normal("<F2>", "bp")
  map_normal("<F3>", "bn")
end

M.fugitive = function()
  -- Git
  map_normal("<leader>gs", "Git")
  map_normal("<leader>gp", "Git push")
  map_normal("<leader>gf", "Git push --force")
  map_normal("<leader>gu", "Git pull")
end

M.vgit = function()
  --- Git Hunk
  map_normal("<leader>hi", "VGit buffer_hunk_preview")
  map_normal("<leader>hs", "VGit buffer_hunk_stage")
  map_normal("<leader>hu", "VGit buffer_hunk_reset")

end

M.telescope = function()
  -- Telescope lists
  map_normal("<space>a", "Telescope autocommands")
  map_normal("<space>b", "Telescope buffers")
  map_normal("<space>c", "Telescope commands")
  map_normal("<space>d", "Telescope diagnostics")
  map_normal("<space>f", "Telescope live_grep")
  map_normal("<space>g", "Telescope git_commits")
  map_normal("<space>h", "Telescope highlights")
  map_normal("<space>k", "Telescope keymaps")
  map_normal("<space>l", "Telescope file_browser")
  map_normal("<space>p", "Telescope find_files")
  map_normal("<space>r", "lua require('lists.repo').list()")
  map_normal("<space>t", "Telescope help_tags")
  map_normal("<space>v", "Telescope vim_options")

  -- Some lsp specific keymaps
  map_normal("<leader>ld", "Telescope lsp_definitions")
  map_normal("<leader>li", "Telescope lsp_implementations")
  map_normal("<leader>lr", "Telescope lsp_references")
  map_normal("<leader>ls", "lua require('lists.symbols').list()")
  map_normal("<leader>lh", "lua vim.lsp.buf.signature_help()")
  map_normal("<leader>lt", "Telescope lsp_type_definitions")
end

return M
