local M = {}
local lspconfig = require("lspconfig")

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
      workspace = {
        checkThirdParty = false,
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
  ts_ls = {
    hostInfo = "neovim",
    preferences = {
      importModuleSpecifierPreference = "project-relative",
    },
  },
}

M.roots = {
  tailwindcss = function(fname)
    local root_pattern = lspconfig.util.root_pattern("tailwind.config.js")
    return root_pattern(fname)
  end,
}

return M
