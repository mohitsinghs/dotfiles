local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local function format()
	vim.lsp.buf.formatting_sync({}, 1000)
end

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
		formatting.shfmt,
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
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "LspFormatting",
				pattern = "<buffer>",
				callback = format,
			})
		end
	end,
})
