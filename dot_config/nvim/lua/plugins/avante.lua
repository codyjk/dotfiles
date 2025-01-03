return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
        link = {
          -- Removes link icon prefix from links
          enabled = false,
        },
        code = {
          -- Removes the language icon (e.g. golang gopher) from the code block header
          style = "normal",
        }
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    hints = { enabled = false },
    windows = {
      sidebar_header = {
        enabled = false,
      },
    },
  }
}
