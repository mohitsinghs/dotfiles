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
      local formatters = require("conform").formatters
      formatters.shfmt = {
        prepend_args = { "-i", "2" },
      }
      formatters.pg_format = {
        prepend_args = { "--spaces", "2", "--no-space-function", "--format-type" },
      }
      formatters.prettierd = {
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/configs/prettierrc.json"),
        },
      }

      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          sql = { "pg_format" },
          sh = { "shfmt" },
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
          if vim.tbl_contains(eslintd_ft, vim.api.nvim_get_option_value("filetype", { buf = args.buf })) then
            vim.lsp.buf_request_sync(args.buf, "workspace/executeCommand", {
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(args.buf) },
            }, 500)
          end
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
