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
	-- Editor
	use("tpope/vim-surround")
	use("numToStr/Comment.nvim")
	use("norcalli/nvim-colorizer.lua")
	-- Git
	use("tpope/vim-fugitive")
	use("tanvirtin/vgit.nvim")
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-refactor")
	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	-- Tools
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	-- LSP
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("b0o/schemastore.nvim")
	-- Snippets
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("rafamadriz/friendly-snippets")
	-- Diagnostics
	use("jose-elias-alvarez/null-ls.nvim")
	-- UI
	use("folke/tokyonight.nvim")
	use("j-hui/fidget.nvim")
	use("stevearc/dressing.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)

require("config")
require("keymaps")
require("lsp")
