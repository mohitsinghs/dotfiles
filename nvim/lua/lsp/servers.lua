local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	client.resolved_capabilities.document_formatting = false
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action, opts)
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
}

local server_opts = {
	["jsonls"] = function(opts)
		opts.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		}
	end,
	["gopls"] = function(opts)
		opts.settings = {
			gopls = {
				experimentalWorkspaceModule = true,
			},
		}
	end,
	["rust_analyzer"] = function(opts)
		opts.settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
				},
				procMacro = {
					enable = true,
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		}
	end,
	["sumneko_lua"] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
				telemetry = {
					enable = false,
				},
			},
		}
	end,
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server_opts[server.name] then
		server_opts[server.name](opts)
	end

	server:setup(opts)
end)
