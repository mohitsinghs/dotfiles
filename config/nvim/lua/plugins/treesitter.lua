return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      local ts = require("nvim-treesitter")
      local ts_config = require("nvim-treesitter.config")
      local langs = require("core.lists").parsers
      ts.install(langs)

      local installed = ts_config.get_installed("parsers")
      local to_install = vim
        .iter(langs)
        :filter(function(parser)
          return not vim.tbl_contains(installed, parser)
        end)
        :totable()

      if #to_install > 0 then
        ts.install(to_install, { summary = true }):wait()
      end

      require("treesitter-context").setup()

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(event)
          local ft = event.match
          local buf = event.buf
          local lang = vim.treesitter.language.get_lang(ft)

          -- stop if filetype is empty, no parser for the language or parser not installed
          if ft == "" or not lang or not vim.tbl_contains(installed, lang) then
            return
          end

          vim.treesitter.start(buf, lang)
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
