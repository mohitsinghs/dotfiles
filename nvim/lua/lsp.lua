local nvim_lsp = require'nvim_lsp'

local function on_attach(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
end


local servers = {'gopls', 'rust_analyzer', 'vuels', 'jsonls', 'vimls', 'pyls', 'cssls', 'html', 'clangd', 'tsserver', 'bashls'}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach=on_attach
  }
end
