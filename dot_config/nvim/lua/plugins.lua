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
  -- theme
  use ({
    'shaunsingh/nord.nvim',
    config = function() require("config/nord") end
  })

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
	-- needed for telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-github.nvim",
			"sharkdp/fd",
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
		},
    config = function() require("config/telescope") end
	})
	use({
		"nvim-telescope/telescope-symbols.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
	})

	use({ "github/copilot.vim" })
	use({
    "ruifm/gitlinker.nvim",
    requires = 'nvim-lua/plenary.nvim',
    config = function() require("config/gitlinker") end
  })

	use({
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require("config/lualine") end
  })

  -- plantuml
	use({
    "weirongxu/plantuml-previewer.vim",
    requires = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax"
    }
  })

  -- markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Packer
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        -- optional configuration
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-context"
    },
    config = function() require("config/treesitter") end,
    run = ":TSUpdate"
  })

  -- codegpt
  use({
    "dpayne/CodeGPT.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    }
  })

  -- oil (netrw replacement)
  use({
    "stevearc/oil.nvim",
    config = function ()
      require("oil").setup({
        -- optional configuration
      })
    end,
  })

	-- migrated from vim
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-rhubarb" })
	use({ "tpope/vim-surround" })
	use({ "rust-lang/rust.vim" })
	use({ "christoomey/vim-tmux-navigator" })
	use({ "tpope/vim-vinegar" })
	use({ "nvim-lua/plenary.nvim" })
end)
