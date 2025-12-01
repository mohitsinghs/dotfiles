local biome_ft = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}

return {
  {
    "mfussenegger/nvim-lint",
    event = "BufReadPre",
    config = function()
      require("lint").linters_by_ft = {
        go = { "golangcilint" },
        dockerfile = { "hadolint" },
        python = { "ruff" },
        sh = { "shellcheck" },
      }

      for _, ft in ipairs(biome_ft) do
        require("lint").linters_by_ft[ft] = { "biomejs" }
      end

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
      local formatters = require("conform").formatters
      formatters.shfmt = {
        prepend_args = { "-i", "2" },
      }
      formatters.pg_format = {
        prepend_args = { "--spaces", "2", "--no-space-function", "--format-type" },
      }

      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_organize_imports", "ruff_format" },
          sql = { "pg_format" },
          sh = { "shfmt" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 5000,
        },
      }

      for _, ft in ipairs(biome_ft) do
        opts.formatters_by_ft[ft] = { "biome-organize-imports", "biome" }
      end

      require("conform").setup(opts)
    end,
  },
}
