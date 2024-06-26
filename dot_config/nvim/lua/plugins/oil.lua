local nmap = require("helpers.keys").nmap
return {
  "stevearc/oil.nvim",
  opts = function()
    nmap("-", "<CMD>Oil<CR>", { desc = "Open file in parent directory" })
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
