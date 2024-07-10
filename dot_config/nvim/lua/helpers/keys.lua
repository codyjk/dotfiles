local map = function(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local lsp_map = function(lhs, rhs, bufnr)
	vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr })
end

local set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	map({ "n", "v" }, key, "<nop>")
end

return {
	map = map,
	lsp_map = lsp_map,
	set_leader = set_leader,
	nmap = function(lhs, rhs)
		map("n", lhs, rhs)
	end,
	vmap = function(lhs, rhs)
		map("v", lhs, rhs)
	end,
	imap = function(lhs, rhs)
		map("i", lhs, rhs)
	end,
}
