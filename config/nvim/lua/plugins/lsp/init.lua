local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = false,
})

return {
  {
    event = "BufReadPre",
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local registry = require("mason-registry")
      local lspconfig = require("lspconfig")
      local lsp_opts = require("plugins.lsp.options")
      local servers = require("plugins.lsp.servers")
      local tools = require("plugins.lsp.tools")
      local neodev = require("neodev")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      registry.refresh(function()
        for _, pkg_name in ipairs(tools) do
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)

      neodev.setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, lsp in pairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
          single_file_support = true,
        }
        if lsp_opts.settings[lsp] ~= nil then
          opts.settings = lsp_opts.settings[lsp]
        end
        if lsp_opts.init[lsp] ~= nil then
          opts.init_options = lsp_opts.init[lsp]
        end
        if lsp_opts.roots[lsp] ~= nil then
          opts.root_dir = lsp_opts.roots[lsp]
          opts.single_file_support = false
        end
        lspconfig[lsp].setup(opts)
      end
    end,
  },
}
