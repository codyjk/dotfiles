-- Display
vim.opt.title = true                  -- Update the title of your window or your terminal
vim.opt.number = true                 -- Display line numbers
vim.opt.ruler = true                  -- Display cursor position
vim.opt.wrap = true                   -- Wrap lines when they are too long
vim.opt.scrolloff = 3                 -- Display at least 3 lines around you cursor (for scrolling)

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

-- Split down and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
