local os_home = vim.loop.os_homedir()
local actions = require("telescope.actions")
local actions_set = require("telescope.actions.set")
local actions_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local finders = require("telescope.finders")
local from_entry = require("telescope.from_entry")
local pickers = require("telescope.pickers")
local t_utils = require("telescope.utils")
local Path = require("plenary.path")
local log = require("telescope.log")

-- Based on https://github.com/cljoly/telescope-repo.nvim

local M = {}

local function normalize_path(opts)
  local displayer = entry_display.create({
    items = { {} },
  })

  local function make_display(entry)
    local dir = (function(path)
      if path == Path.path.root() then
        return path
      end

      local p = Path:new(path)
      if opts.tail_path then
        local parts = p:_split()
        return parts[#parts]
      end

      if opts.shorten_path then
        return p:shorten()
      end

      if vim.startswith(path, opts.cwd) and path ~= opts.cwd then
        return Path:new(p):make_relative(opts.cwd)
      end

      if vim.startswith(path, os_home) then
        return (Path:new("~") / p:make_relative(os_home)).filename
      end
      return path
    end)(entry.path)

    return displayer({ dir })
  end

  return function(line)
    return {
      value = line,
      ordinal = line,
      path = line,
      display = make_display,
    }
  end
end

local function find_repos(opts)
  opts = opts or {}
  if vim.fn.executable("repo") == 1 then
    opts.bin = "repo"
  end
  if opts.bin == "" then
    error("repo not found, is repo installed?")
  end
  opts.cwd = vim.env.HOME

  local repo_command = { opts.bin }
  local find_repo_opts = { "cmp", "--full" }

  -- Expand '~'
  local search_dirs = {}
  for i, d in ipairs(opts.search_dirs or {}) do
    search_dirs[i] = vim.fn.expand(d)
  end

  table.insert(repo_command, find_repo_opts)
  table.insert(repo_command, search_dirs)
  repo_command = vim.tbl_flatten(repo_command)
  log.trace("repo command: " .. vim.inspect(repo_command))

  return repo_command
end

M.list = function(opts)
  opts = opts or {}
  opts.entry_maker = t_utils.get_lazy_default(opts.entry_maker, normalize_path, opts)
  local repo_command = find_repos(opts)
  local prompt_title = "Git repositories"
  pickers.new(opts, {
    prompt_title = prompt_title,
    finder = finders.new_oneshot_job(repo_command, opts),
    previewer = false,
    sorter = conf.file_sorter(opts),
    layout_config = {
      width = 60,
    },
    layout_strategy = "center",
    attach_mappings = function(prompt_bufnr)
      actions_set.select:replace(function(_, _)
        local entry = actions_state.get_selected_entry()
        local dir = from_entry.path(entry)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          vim.cmd("cd" .. dir)
          require("telescope.builtin").find_files({ cwd = dir })
        end)
      end)
      return true
    end,
  }):find()
end

return M
