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
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	-- LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("rafamadriz/friendly-snippets")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("jose-elias-alvarez/null-ls.nvim")
	use("b0o/schemastore.nvim")
	use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")
	-- Lua
	use("kyazdani42/nvim-web-devicons")
	use("tanvirtin/vgit.nvim")
	use("nvim-lualine/lualine.nvim")
	use("j-hui/fidget.nvim")
	use("stevearc/dressing.nvim")
	use("norcalli/nvim-colorizer.lua")
	if packer_bootstrap then
		require("packer").sync()
	end
end)

require("config")
require("keymaps")
require("lsp")
