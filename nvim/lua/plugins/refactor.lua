local prettierd_ft = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "css",
  "scss",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
}

local eslintd_ft = {
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
        python = { "flake8" },
        sh = { "shellcheck" },
      }

      for _, ft in ipairs(eslintd_ft) do
        require("lint").linters_by_ft[ft] = { "eslint_d" }
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
      require("conform.formatters.shfmt").args = { "-i", "2" }
      require("conform.formatters.pg_format").args = {
        "--spaces 2",
        "--comma-end",
        "--no-space-function",
        "--format-type",
      }
      require("conform.formatters.prettierd").args = {
        "--jsx-single-quote",
        "--single-quote",
        "--no-semi",
        "$FILENAME",
      }
      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          sql = { "pg_format" },
          go = { "gofmt" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
      }

      for _, ft in ipairs(prettierd_ft) do
        opts.formatters_by_ft[ft] = { "prettierd" }
      end

      require("conform").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
