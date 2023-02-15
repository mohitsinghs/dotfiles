local M = {}

M.on_highlights = function(hl, c)
  hl.NeoTreeGitAdded = { fg = c.green }
  hl.NeoTreeGitConflict = { fg = c.red }
  hl.NeoTreeGitDeleted = { fg = c.red }
  hl.NeoTreeGitIgnored = { fg = c.dark5 }
  hl.NeoTreeGitModified = { fg = c.yellow }
  hl.NeoTreeGitUntracked = { fg = c.blue }

  hl.NeoTreeGitUnstaged = { fg = c.red }
  hl.NeoTreeGitStaged = { fg = c.green }
  hl.NeoTreeModified = { fg = c.yellow }

  hl.NeoTreeTabActive = { fg = c.fg, bg = c.bg_dark }
  hl.NeoTreeTabInactive = { fg = c.dark5, bg = c.bg_highlight }
  hl.NeoTreeIndentMarker = { fg = c.fg_gutter }
  hl.NeoTreeDirectoryIcon = { fg = c.fg }
  hl.NeoTreeDirectoryName = { fg = c.fg_dark }
  hl.NeoTreeSymbolicLinkTarget = { fg = c.purple }
  hl.NeoTreeRootName = { fg = c.blue }
  hl.NeoTreeFileNameOpened = { fg = c.purple }

  hl.GitHeader = { bg = c.black }
  hl.GitFooter = { bg = c.black }
end

return M
