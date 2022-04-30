local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local function format()
	vim.lsp.buf.formatting_sync({}, 1000)
end

null_ls.setup({
	sources = {
		-- formatters
		formatting.stylua,
		formatting.prettier,
		formatting.black,
		formatting.gofmt,
		formatting.rustfmt,
		formatting.shfmt,
		-- completions
		diagnostics.eslint,
		diagnostics.shellcheck,
		diagnostics.hadolint,
		diagnostics.golangci_lint,
		diagnostics.flake8,
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
