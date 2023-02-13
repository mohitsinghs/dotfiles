local M = {}

M.format = function(buf)
  local ft = vim.bo[buf].filetype
  local supports_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
  vim.lsp.buf.format({
    filter = function(client)
      if supports_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
    bufnr = buf,
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

M.on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat", {}),
      buffer = bufnr,
      callback = function()
        M.format(bufnr)
      end,
    })
  end
end

return M
