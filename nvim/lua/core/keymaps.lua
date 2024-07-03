local M = {}

vim.g.mapleader = ","

local function nmap(key, cmd)
  vim.api.nvim_set_keymap("n", key, ":<C-u>" .. cmd .. "<cr>", { noremap = true, silent = true })
end

M.core = function()
  -- Write and quit
  nmap("<leader>q", "q")
  nmap("<leader>w", "w")
  nmap("<leader>ws", "noa w")
  nmap("<leader>wa", "wa")
  nmap("<leader>wtf", "w !sudo tee >/dev/null %")
  nmap("<leader>i", "Inspect")

  -- Switch themes
  nmap("<leader>c", "lua require('core.themer').cycle_theme()")

  -- Tasklist
  nmap("<leader>tt", "lua require('core.tasklist').toggle_task()")
  nmap("<leader>tn", "lua require('core.tasklist').new_task()")
end

M.fugitive = function()
  -- Git
  nmap("<leader>gs", "Git")
  nmap("<leader>gp", "Git push")
  nmap("<leader>gf", "Git push --force")
  nmap("<leader>gu", "Git pull")
end

M.vgit = function()
  --- Git Hunk
  nmap("<leader>hi", "VGit buffer_hunk_preview")
  nmap("<leader>hs", "VGit buffer_hunk_stage")
  nmap("<leader>hu", "VGit buffer_hunk_reset")
  nmap("<leader>bh", "VGit buffer_history_preview")
  nmap("<leader>bd", "VGit buffer_diff_preview")
end

M.telescope = function()
  -- Telescope lists
  nmap("<space>a", "Telescope autocommands")
  nmap("<space>b", "Telescope buffers")
  nmap("<space>c", "Telescope commands")
  nmap("<space>d", "Telescope diagnostics")
  nmap("<space>f", "Telescope live_grep")
  nmap("<space>g", "Telescope git_commits")
  nmap("<space>h", "Telescope highlights")
  nmap("<space>k", "Telescope keymaps")
  nmap("<space>o", "Telescope vim_options")
  nmap("<space>p", "Telescope find_files")
  nmap("<space>r", "Telescope repo")
  nmap("<space>t", "Telescope help_tags")

  -- Some lsp specific keymaps
  nmap("<leader>ld", "Telescope lsp_definitions")
  nmap("<leader>li", "Telescope lsp_implementations")
  nmap("<leader>lr", "Telescope lsp_references")
  nmap("<leader>ls", "lua require('lists.symbols').list()")
  nmap("<leader>lh", "lua vim.lsp.buf.signature_help()")
  nmap("<leader>lt", "Telescope lsp_type_definitions")
end

return M
