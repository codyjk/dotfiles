require("mason").setup()
require("mason-lspconfig").setup({
		ensure_installed = { "tsserver", "rust_analyzer", "sumneko_lua" }
	})
