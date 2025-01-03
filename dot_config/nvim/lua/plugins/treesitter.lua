return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.2",
  build = ":TSUpdate",
  dependencies = {
    {"nvim-treesitter/nvim-treesitter-textobjects"}, -- Syntax aware text-objects
    {
      "nvim-treesitter/nvim-treesitter-context", -- Show code context
      opts = {enable = false, mode = "topline", line_numbers = true}
    }
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"markdown"},
      callback = function(ev)
        -- treesitter-context is buggy with Markdown files
        require("treesitter-context").disable()
      end
    })

    treesitter.setup({
      ensure_installed = {
        "go",
        "gomod",
        "gosum",
        "gowork",
        "lua",
        "markdown",
        "python",
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
