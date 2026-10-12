-- Colorschemes for the `theme` command. scripts/theme.lua picks one.
-- lazy.nvim loads each plugin when its colorscheme is first used.
-- quiet ships with Neovim, so it needs no plugin.
-- scripts/theme.lua turns italics off for all of them.
return {
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    init = function()
      vim.g.nord_contrast = false
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = true,
    init = function()
      vim.g.zenwritten = { italic_comments = false, italic_strings = false }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      background = { dark = "dragon", light = "lotus" },
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },
  {
    "datsfilipe/vesper.nvim",
    lazy = true,
    opts = {
      italics = { comments = false, keywords = false, functions = false, strings = false, variables = false },
    },
  },
  { "p00f/alabaster.nvim", lazy = true },
}
