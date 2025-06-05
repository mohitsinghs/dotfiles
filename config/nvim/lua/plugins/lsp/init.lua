local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
end

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = false,
  signs = { Error = " ", Warn = " ", Hint = " ", Info = " " },
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
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local registry = require("mason-registry")
      local servers = require("plugins.lsp.servers")
      local tools = require("plugins.lsp.tools")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      registry.refresh(function()
        for _, pkg_name in ipairs(tools) do
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      vim.lsp.config("*", { on_attach = on_attach, capabilities = capabilities })
    end,
  },
}
