return {
  "supermaven-inc/supermaven-nvim",
  config = function()
  -- Unmap <C-J> (so it can be used as completion
  vim.api.nvim_set_keymap('i', '<C-J>', '', { noremap = true, silent = true })
    require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-J>",
          clear_suggestion = "<C-]>",
          accept_word = "<Tab>",
        },
    })
  end,
}
