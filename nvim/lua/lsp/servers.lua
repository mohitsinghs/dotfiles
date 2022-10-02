local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp_opts = require("lsp.opts")

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

local servers = {
	"pyright",
	"tsserver",
	"cssls",
	"html",
	"dockerls",
	"tailwindcss",
	"jsonls",
	"gopls",
	"rust_analyzer",
	"sumneko_lua",
	"yamlls",
	"bashls",
	"graphql",
}

mason.setup()
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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
