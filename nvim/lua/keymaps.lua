vim.g.mapleader = ","

local function map_normal(key, cmd)
	vim.api.nvim_set_keymap("n", key, ":" .. cmd .. "<cr>", { noremap = true, silent = true })
end

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

-- Git
map_normal("<leader>gs", "Git")
map_normal("<leader>gp", "Git push")
map_normal("<leader>gf", "Git push --force")
map_normal("<leader>gu", "Git pull")

--- Git Hunk
map_normal("<leader>hu", "VGit buffer_hunk_reset")
map_normal("<leader>hi", "VGit buffer_hunk_preview")
map_normal("<leader>hs", "VGit buffer_hunk_stage")

-- Telescope lists
map_normal("<space>r", "<C-u>lua require('lists.repo').list()")
map_normal("<space>p", "<C-u>Telescope find_files")
map_normal("<space>f", "<C-u>Telescope live_grep")
map_normal("<space>g", "<C-u>Telescope git_commits")
map_normal("<space>b", "<C-u>Telescope buffers")
map_normal("<space>c", "<C-u>Telescope highlights")
map_normal("<space>o", "<C-u>Telescope vim_options")
map_normal("<space>h", "<C-u>Telescope help_tags")
map_normal("<space>m", "<C-u>Telescope man_pages")
map_normal("<space>d", "Telescope diagnostics")
map_normal("<space>s", "lua require('lists.symbols').list()")

-- Some lsp specific keymaps
map_normal("<leader>lr", "Telescope lsp_references")
map_normal("<leader>ld", "Telescope lsp_definitions")
map_normal("<leader>ly", "Telescope lsp_type_definitions")
map_normal("<leader>li", "Telescope lsp_implementations")

-- Extra
map_normal("<leader>n", "NvimTreeToggle")
