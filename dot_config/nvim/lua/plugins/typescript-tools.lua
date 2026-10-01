return {
  "pmizio/typescript-tools.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  -- Needs node and the typescript package (installed by the node module).
  cond = function() return vim.fn.executable("node") == 1 end,
  config = function()
    require("typescript-tools").setup({
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayVariableTypeHints = true,
        },
      },
      on_attach = function(client, bufnr)
       require("helpers.lsp-on-attach")(client, bufnr)
      end,
    })
  end,
}
