require('plugins')

vim.g.mapleader = ','

local map = function(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local nmap = function(shortcut, command)
  map('n', shortcut, command)
end

local imap = function(shortcut, command)
  map('i', shortcut, command)
end

-- Display
vim.opt.title = true                  -- Update the title of your window or your terminal
vim.opt.number = true                 -- Display line numbers
vim.opt.ruler = true                  -- Display cursor position
vim.opt.wrap = true                   -- Wrap lines when they are too long
vim.opt.scrolloff = 3                 -- Display at least 3 lines around you cursor (for scrolling)
vim.opt.guioptions = 'T'              -- Enable the toolbar

-- Search
vim.opt.ignorecase = true             -- Ignore case when searching
vim.opt.smartcase = true              -- If there is an uppercase in your search term
                                      -- search case sensitive again
vim.opt.incsearch = true              -- Highlight search results when typing
vim.opt.hlsearch = true               -- Highlight search results

-- Beep
vim.opt.visualbell = true             -- Prevent Vim from beeping

-- Backspace behaves as expected
vim.opt.backspace = { "indent", "eol", "start" }

-- Hide buffer (file) instead of abandoning when switching to another buffer
vim.opt.hidden = true

-- Disabling the directional keys
nmap("<up>", "<nop>")
nmap("<down>", "<nop>")
nmap("<left>", "<nop>")
nmap("<right>", "<nop>")
imap("<up>", "<nop>")
imap("<down>", "<nop>")
imap("<left>", "<nop>")
imap("<right>", "<nop>")

-- Disabling the mouse
vim.opt.mouse = ""

-- show existing tab with 2 spaces width
vim.opt.tabstop = 2

-- when indenting with '>', use 2 spaces width
vim.opt.shiftwidth = 2

-- On pressing tab, insert 2 spaces
vim.opt.expandtab = true

-- Line length marker
vim.opt.colorcolumn = "80"

-- Un-highlight whatever is highlighted
nmap("<Leader>x", ":nohl <CR>")

-- Allow jsx in js files
vim.g.jsx_ext_required = 0

-- Use `.bash_profile` and aliases in shell
vim.opt.shell = "/bin/bash --rcfile ~/.bash_profile"

-- Split down and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Go to next item in clist
nmap("<C-n>", ":cn<cr>")

-- copilot config
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
vim.g.copilot_node_command = "/Users/cjk/.asdf/installs/nodejs/17.9.1/bin/node"

-- oil file navigation config
vim.api.nvim_set_keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- theme
vim.cmd[[colorscheme nord]]
