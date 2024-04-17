return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true;
      opts.current_line_blame_opts.virt_text = true;
      -- TODO fix
      -- 'eol' | 'overlay' | 'right_align'
      -- opts.current_line_blame_opts.virt_text_pos = 'eol';
      -- opts.current_line_blame_opts.delay = 1000;
      -- opts.current_line_blame_opts.ignore_whitespace = false;
      -- opts.current_line_blame_formatter = '\t\t<author>, <author_time:%Y-%m-%d> - <summary> ';
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
  },
  "tpope/vim-fugitive",
}
