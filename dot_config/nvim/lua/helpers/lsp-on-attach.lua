local lsp_map = require("helpers.keys").lsp_map
local on_attach = function(_, bufnr)
  local builtins = require("telescope.builtin")

  -- Show diagnostics
  lsp_map("<leader>e", vim.diagnostic.open_float, bufnr)

  -- Rename symbol
  lsp_map("<leader>rn", vim.lsp.buf.rename, bufnr)

  -- Code actions
  lsp_map("<leader>ca", vim.lsp.buf.code_action, bufnr)

  -- Goto definition
  lsp_map("gd", builtins.lsp_definitions, bufnr)

  -- Goto references
  lsp_map("gr", builtins.lsp_references, bufnr)

  -- Show hover documentation
  lsp_map("K", vim.lsp.buf.hover, bufnr)
end

return on_attach
