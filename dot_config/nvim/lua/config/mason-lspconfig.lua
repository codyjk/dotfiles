require("mason").setup()
require("mason-lspconfig").setup({
		ensure_installed = { "tsserver", "rust_analyzer", "lua_ls" }
	})
