local nmap = require("helpers.keys").nmap
return {
  "stevearc/oil.nvim",
  opts = function()
    nmap("-", "<CMD>Oil<CR>")
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
