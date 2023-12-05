local M = {}

local function is_valid_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.fn.bufexists(bufnr) and vim.fn.bufloaded(bufnr) and vim.bo.filetype == "markdown"
end

M.toggle_task = function()
  if not is_valid_buffer() then
    return
  end

  local lnum = vim.fn.line(".")
  if not (type(lnum) == "number" and lnum > 0 and lnum <= vim.fn.line("$")) then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]

  if string.match(line, "%[ %]") then
    local new_line = string.gsub(line, "%[ %]", "[x]", 1)
    vim.api.nvim_buf_set_lines(bufnr, lnum - 1, lnum, false, { new_line })
  elseif string.match(line, "%[x%]") then
    local new_line = string.gsub(line, "%[x%]", "[ ]", 1)
    vim.api.nvim_buf_set_lines(bufnr, lnum - 1, lnum, false, { new_line })
  end
end

function M.new_task()
  if not is_valid_buffer() then
    return
  end

  local lnum = vim.fn.line(".")
  if not (type(lnum) == "number" and lnum > 0 and lnum <= vim.fn.line("$")) then
    return
  end
  local new_task_str = "- [ ] "
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local current_line = lines[lnum]
  local leads = current_line:match("^%s*")
  table.insert(lines, lnum + 1, leads .. new_task_str)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(0, { lnum + 1, #leads + string.len(new_task_str) + 1 })
end

return M
