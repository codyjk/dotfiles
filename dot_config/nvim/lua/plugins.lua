vim.cmd [[packadd packer.nvim]] -- packadd packer module

return require('packer').startup(function(use)
	-- make sure to add this line to let packer manage itself
	use('wbthomason/packer.nvim')

	-- LSP
	use({
			"williamboman/mason.nvim",
			config = function() require("mason").setup() end
		})
	use({
			"williamboman/mason-lspconfig.nvim",
			requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
			config = function()
				require("mason").setup()
				require("mason-lspconfig").setup({
						ensure_installed = { "tsserver", "rust_analyzer", "sumneko_lua" }
					})
			end
		})
	use({ "neovim/nvim-lspconfig", config = function() require("lsp") end })

	-- auto-complete
	use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip"
			},
			config = function() require("nvim-cmp") end
		})
end)
