local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp_opts = require("lsp.opts")

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	client.resolved_capabilities.document_formatting = false
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

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

for _, lsp in pairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		root_dir = lspconfig.util.find_git_ancestor,
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
