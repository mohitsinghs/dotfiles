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
      schemas = require("schemastore").yaml.schemas(),
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
