return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.2",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Syntax aware text-objects
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = {
        "lua",
        "markdown",
        "python",
        "rust",
        "vim",
        "vimdoc",
        "sql",
        "yaml",
        "typescript",
        "javascript",
        "tsx"
      },
      indent = {enable = true},
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          disable = { "typescript", "tsx" } -- Temporarily disable for TS/TSX
        }
      }
    })
  end
}
