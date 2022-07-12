" vim-plug
call plug#begin('~/.vim/plugged')
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-vinegar'
Plug 'vimwiki/vimwiki'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ruifm/gitlinker.nvim'
Plug 'sainnhe/everforest'
call plug#end()

" Cancel the compatibility with Vi. Essential if you want
" to enjoy the features of Vim
set nocompatible

" -- Display
set title                 " Update the title of your window or your terminal
set number                " Display line numbers
set ruler                 " Display cursor position
set wrap                  " Wrap lines when they are too long
set scrolloff=3           " Display at least 3 lines around you cursor (for scrolling)
set guioptions=T          " Enable the toolbar

" -- Search
set ignorecase            " Ignore case when searching
set smartcase             " If there is an uppercase in your search term
                          " search case sensitive again
set incsearch             " Highlight search results when typing
set hlsearch              " Highlight search results

" -- Beep
set visualbell            " Prevent Vim from beeping
set noerrorbells          " Prevent Vim from beeping

" Backspace behaves as expected
set backspace=indent,eol,start

" Hide buffer (file) instead of abandoning when switching
" to another buffer
set hidden

" Enable syntax highlighting
syntax enable

" Use new regular expression engine
set re=0

" Enable file specific behavior like syntax highlighting and indentation
filetype on
filetype plugin on
filetype indent on

" Set up theme and colors. Silence any colorscheme errors since it won't be
" present the first time vimrc is loaded
" https://github.com/tmux/tmux/issues/1246
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
silent! colorscheme everforest
set background=dark

" Disabling the directional keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Set <Leader>
let mapleader = ","

" show existing tab with 2 spaces width
set tabstop=2

" when indenting with '>', use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 2 spaces
set expandtab

" Statusline
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l/%3L,%02c%03V%)

" Line length marker
set colorcolumn=80

" FZF fuzzy finder
noremap <C-p> :GFiles <CR>
noremap <Leader>b :Buffers <CR>
noremap <Leader>h :Help <CR>

" Ctrl-l to remove highlighted stuff
nmap <Leader>x :nohl <CR>

" Allow jsx in js files
let g:jsx_ext_required = 0

" Use `.bash_profile` and aliases in shell
set shell=/bin/bash\ --rcfile\ ~/.bash_profile

" Split down and to the right
set splitbelow
set splitright

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" simple navigation through clist
noremap <C-n> :cn<cr>

" allow project specific stuff
set exrc
set secure

" coc config
let g:coc_disable_startup_warning = 1
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" auto-completion: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" use <tab> for trigger completion and navigate to the next complete item
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" netrw file explorer config
" default to tree view
let g:netrw_liststyle = 3

" width of explorer is 20% of window
let g:netrw_winsize = 20

" close explorer after selecting file
let g:netrw_altv = 0

" typescript highlighting for prisma
autocmd BufNewFile,BufRead *.prisma set syntax=typescript
