return {
  { "kylechui/nvim-surround", event = "BufReadPost", config = true },
  {
    "catgoose/nvim-colorizer.lua",
    opts = { "*" },
    event = "BufReadPost",
    config = true,
  },
}
