return {
  {
    event = "BufReadPre",
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local registry = require("mason-registry")
      local lists = require("core.lists")

      vim.diagnostic.config({
        virtual_lines = true,
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      mason.setup()

      -- auto install all tools
      registry.refresh(function()
        for _, pkg_name in ipairs(lists.tools) do
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        end,
      })

      mason_lspconfig.setup({
        ensure_installed = lists.servers,
        automatic_enable = true,
      })

      -- vim.iter(lists.servers):each(function(server)
      --   local has_custom_opts, opts = pcall(require, "lsp." .. server)
      --   if has_custom_opts then
      --     vim.lsp.config[server] = opts
      --   end
      -- end)
    end,
  },
}
