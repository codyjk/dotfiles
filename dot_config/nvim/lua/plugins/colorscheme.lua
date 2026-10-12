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
      vim.g.zenbones = { italic_comments = false, italic_strings = false }
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
  -- From vim-no-color-collections. noclown is a single public-domain file
  -- kept in colors/noclown.vim. zenbones comes from zenbones.nvim above.
  { "huyvohcmc/atlas.vim", lazy = true },
  { "LuRsT/austere.vim", lazy = true },
  { "chriskempson/base16-vim", lazy = true },
  { "ntk148v/komau.vim", lazy = true },
  { "kvrohit/rasmus.nvim", lazy = true },
  { "kadekillary/skull-vim", lazy = true },
  { "t184256/vim-boring", lazy = true },
  { "pbrisbin/vim-colors-off", lazy = true },
  { "fxn/vim-monochrome", lazy = true },
  {
    "Lokaltog/vim-monotone",
    lazy = true,
    init = function()
      -- monotone skips loading when g:loaded_monotone is set, so switching
      -- back to it in a running Neovim would do nothing. Clear the flag first.
      vim.api.nvim_create_autocmd("ColorSchemePre", {
        pattern = "monotone",
        callback = function() vim.g.loaded_monotone = nil end,
      })
    end,
  },
  { "YorickPeterse/vim-paper", lazy = true },
  { "hardselius/warlock", lazy = true },
}
