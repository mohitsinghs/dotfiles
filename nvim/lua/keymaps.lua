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
map_normal("<space>h", "<C-u>Telescope highlights")

-- Some lsp specific keymaps
map_normal("<leader>gr", "Telescope lsp_references")
map_normal("<leader>gd", "Telescope lsp_definitions")
map_normal("<leader>gy", "Telescope lsp_type_definitions")
map_normal("<leader>gi", "Telescope lsp_implementations")
map_normal("<leader>so", "lua require('lists.symbols').list()")

-- Extra
map_normal("<leader>n", "NvimTreeToggle")
