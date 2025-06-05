return {
  settings = {
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
}
