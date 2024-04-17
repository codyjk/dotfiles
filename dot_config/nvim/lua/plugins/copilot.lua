return {
 "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
    vim.g.copilot_node_command = "/Users/cjk/.asdf/installs/nodejs/20.12.1/bin/node"
  end,
}
