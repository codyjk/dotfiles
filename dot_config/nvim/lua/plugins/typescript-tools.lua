return {
  "pmizio/typescript-tools.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
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
