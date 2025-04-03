local function configFrom(colors)
  local mode_color = {
    n = colors.cyan,
    i = colors.green,
    v = colors.magenta,
    c = colors.red,
    no = colors.magenta,
    s = colors.orange,
    [""] = colors.orange,
    ic = colors.yellow,
    R = colors.magenta,
    Rv = colors.magenta,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.red,
  }

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand("%:p:h")
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  local function lookup_color(map, func)
    return function()
      return { fg = map[func()], bg = colors.bg_dark }
    end
  end

  local function wrap_start(cb, color)
    if type(color) == "string" then
      color = { fg = color, bg = colors.bg_dark }
    end
    return {
      {
        function()
          return "▊"
        end,
        color = { fg = colors.blue, bg = colors.bg_dark },
        padding = { left = 0, right = 0 },
      },
      { cb, color = color },
      {
        function()
          return ""
        end,
        color = { fg = colors.bg_dark, bg = colors.bg_highlight },
        padding = 0,
      },
    }
  end

  local git_branch = {
    {
      function()
        return ""
      end,
      color = { fg = colors.bg_dark },
      cond = conditions.check_git_workspace,
      padding = 0,
    },
    {
      "branch",
      icon = "",
      cond = conditions.check_git_workspace,
      color = { fg = colors.purple, gui = "bold", bg = colors.bg_dark },
    },
    {
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = 0,
    },
  }

  local ext_fugitive = {
    sections = {
      lualine_c = wrap_start(function()
        return " " .. vim.fn.FugitiveHead()
      end, colors.magenta),
      lualine_x = { { "location", icon = "" } },
    },
    filetypes = { "fugitive" },
  }

  local ext_telescope = {
    sections = {
      lualine_c = wrap_start(function()
        return "  Telescope"
      end, colors.cyan),
    },
    filetypes = { "TelescopePrompt" },
  }

  local ext_neotree = {
    sections = {
      lualine_c = wrap_start(function()
        return "  Neotree"
      end, colors.cyan),
      lualine_x = git_branch,
    },
    filetypes = { "neo-tree" },
  }

  local empty_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  }

  local config = {
    options = {
      globalstatus = true,
      component_separators = "",
      section_separators = "",
      theme = {
        normal = { c = { fg = colors.dark5, bg = colors.bg_highlight } },
        inactive = { c = { fg = colors.dark5, bg = colors.bg_dark } },
      },
    },
    sections = empty_sections,
    inactive_sections = empty_sections,
    extensions = {
      ext_fugitive,
      ext_telescope,
      ext_neotree,
    },
  }

  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  config.sections.lualine_c = wrap_start(function()
    return require("lualine.utils.mode").get_mode()
  end, lookup_color(mode_color, vim.fn.mode))

  ins_left({ "filename", cond = conditions.buffer_not_empty })
  ins_left({ icon = "󰈚", "filesize", cond = conditions.buffer_not_empty })

  ins_left({ "diagnostics", sources = { "nvim_diagnostic" } })

  ins_left({
    function()
      return "%="
    end,
  })

  ins_right({ "lsp_status" })

  ins_right({
    "o:encoding",
    fmt = string.upper,
    cond = conditions.hide_in_width,
  })

  ins_right({
    "fileformat",
    fmt = string.upper,
    padding = {
      right = 2,
      left = 1,
    },
  })

  ins_right({
    "diff",
    symbols = { added = " ", modified = " ", removed = " " },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
  })

  vim.list_extend(config.sections.lualine_x, git_branch)

  return config
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local colors = require("tokyonight.colors").setup()
      return configFrom(colors)
    end,
    init = function()
      local lualine = require("lualine")
      local function refresh()
        local colors = require("tokyonight.colors").setup({ transform = true })
        local config = configFrom(colors)
        lualine.setup(config)
      end
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = refresh,
      })
    end,
  },
}
