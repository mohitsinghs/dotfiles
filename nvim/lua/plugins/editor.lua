return {
  { "kylechui/nvim-surround", event = "BufReadPost", config = true },
  {
    "norcalli/nvim-colorizer.lua",
    opts = { "*" },
    event = "BufReadPost",
    config = true,
  },
}
