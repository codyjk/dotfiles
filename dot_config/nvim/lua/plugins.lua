vim.cmd [[packadd packer.nvim]] -- packadd packer module

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

return require('packer').startup(function(use)
	-- make sure to add this line to let packer manage itself
	use('wbthomason/packer.nvim')

	-- LSP
	use({
			"williamboman/mason.nvim",
		})
	use({
			"williamboman/mason-lspconfig.nvim",
			requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
			config = function () require("config/mason-lspconfig") end
		})
	use({
			"neovim/nvim-lspconfig",
			config = function() require("config/lsp") end
		})

	-- auto-complete
	use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip",
				"onsails/lspkind.nvim"
			},
			config = function() require("config/nvim-cmp") end
		})

	-- git gutter and inline blame
	use({
			"lewis6991/gitsigns.nvim",
			config = function() require("config/gitsigns") end
		})
	end)
