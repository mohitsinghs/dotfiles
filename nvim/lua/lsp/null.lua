local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local function format()
	vim.lsp.buf.formatting_sync({}, 1000)
end

null_ls.setup({
	root_dir = require("lspconfig").util.find_git_ancestor,
	sources = {
		-- formatters
		formatting.stylua,
		formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/configs/prettierrc.json"),
			},
		}),
		formatting.black.with({
			timeout = 5000,
		}),
		formatting.gofmt,
		formatting.rustfmt,
		formatting.shfmt,
		-- diagnostics
		diagnostics.eslint_d,
		diagnostics.shellcheck,
		diagnostics.hadolint,
		diagnostics.golangci_lint,
		diagnostics.flake8,
		diagnostics.proselint,
		diagnostics.write_good,
		diagnostics.alex,
		diagnostics.codespell,
		-- code_actions
		code_actions.eslint_d,
		code_actions.shellcheck,
		code_actions.proselint,
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
