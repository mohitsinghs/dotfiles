local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = "init.lua",
})

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("folke/tokyonight.nvim")
	use("tpope/vim-surround")
	use("tpope/vim-fugitive")
	use("tpope/vim-commentary")
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-refactor")
	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("mohitsinghs/telescope-repo.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("jose-elias-alvarez/null-ls.nvim")
	use("b0o/schemastore.nvim")
	-- Lua
	use("kyazdani42/nvim-web-devicons")
	use("tanvirtin/vgit.nvim")
	use("nvim-lualine/lualine.nvim")
	use("arkav/lualine-lsp-progress")
	use("stevearc/dressing.nvim")
	if packer_bootstrap then
		require("packer").sync()
	end
end)

require("config")
require("keymaps")
require("plugins")
require("treesitter")
require("lsp")
