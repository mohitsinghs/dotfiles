local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        filter = function()
          if client.supports_method("textDocument/formatting") then
            -- use null-ls to format when lsp is not available
            return client.name ~= "null-ls"
          else
            return client.name == "null-ls"
          end
        end,
        bufnr = bufnr,
      })
    end,
  })
end

return M
