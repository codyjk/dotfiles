set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')
lua require('gitlinker').setup()
lua require('nvim-autopairs').setup({ map_cr = false })
