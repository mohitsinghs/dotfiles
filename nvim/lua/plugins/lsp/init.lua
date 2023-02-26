local on_attach = function(client, bufnr)
  require("plugins.lsp.format").on_attach(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = true,
})

return {
  {
    event = "BufReadPre",
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "b0o/schemastore.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local lsp_opts = require("plugins.lsp.options")
      local servers = require("plugins.lsp.servers")
      local neodev = require("neodev")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
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
        lspconfig[lsp].setup(opts)
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    opts = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions
      return {
        on_attach = function(client, bufnr)
          require("plugins.lsp.format").on_attach(client, bufnr)
        end,
        sources = {
          -- formatters
          formatting.stylua,
          formatting.prettierd.with({
            env = {
              PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/configs/prettierrc.json"),
            },
          }),
          formatting.black,
          formatting.gofmt,
          formatting.shfmt.with({
            extra_args = { "-i", "2" },
          }),
          -- diagnostics
          diagnostics.eslint_d,
          diagnostics.shellcheck,
          diagnostics.hadolint,
          diagnostics.golangci_lint,
          diagnostics.flake8,
          -- code_actions
          code_actions.eslint_d,
          code_actions.shellcheck,
        },
      }
    end,
  },
}
