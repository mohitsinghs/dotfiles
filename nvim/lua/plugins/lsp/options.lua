local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local M = {}

M.settings = {
  jsonls = {
    schemas = require("schemastore").json.schemas(),
    validate = { enable = true },
  },
  rust_analyzer = {
    ["rust-analyzer"] = {
      cargo = {
        allfeatures = true,
        loadoutdirsfromcheck = true,
      },
      procmacro = {
        enable = true,
      },
      checkonsave = {
        command = "clippy",
      },
    },
  },
  lua_ls = {
    Lua = {
      runtime = {
        version = "luajit",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = false,
      },
    },
  },
  yamlls = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}

M.init = {
  tsserver = {
    hostInfo = "neovim",
    preferences = {
      importModuleSpecifierPreference = "project-relative",
    },
  },
}

return M
