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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
