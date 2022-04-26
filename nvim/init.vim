if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'folke/tokyonight.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mohitsinghs/telescope-repo.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'b0o/schemastore.nvim'
" Lua
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tanvirtin/vgit.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
Plug 'stevearc/dressing.nvim'

call plug#end()

lua require('plugins')
lua require('treesitter')
lua require('keymaps')
lua require('lsp')

" Basic
set mouse:a noswf nu rnu ls=2 shm=aIFWc tgc ts=2 sw=2 sts=2 et nofen fenc=utf-8 cb+=unnamedplus ut=250 scl=yes
set wig+=*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc
set list lcs=tab:··,trail:·

" Theme Configs
colo tokyonight

" Bold and italic in tmux
set t_ZH=[3m
set t_ZR=[23m

hi Comment cterm=italic gui=italic
