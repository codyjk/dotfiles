local builtins = require("telescope.builtin")

local map = function(mode, keys, func, desc, bufnr)
	vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc, noremap = true })
end

local nmap = function(keys, func, desc, bufnr)
	map("n", keys, func, desc, bufnr)
end

nmap("<leader>f", builtins.builtin)
nmap("<leader>ff", builtins.find_files)
nmap("<leader>fg", builtins.live_grep)
nmap("<C-p>", builtins.git_files)
nmap("<leader>b", builtins.buffers)
nmap("<leader>h", builtins.help_tags)
nmap("gd", builtins.lsp_definitions)
nmap("gr", builtins.lsp_references)
nmap("<leader>fG", builtins.grep_string)
nmap("<leader>fr", builtins.resume)
