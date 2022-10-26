local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local lsp_format = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
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
		formatting.rustfmt,
		formatting.shfmt.with({
			extra_args = function(params)
				return { "-i", vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth") }
			end,
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
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_format(bufnr)
				end,
			})
		end
	end,
})
