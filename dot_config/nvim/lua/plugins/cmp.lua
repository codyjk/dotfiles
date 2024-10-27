return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- cmp_nvim_lsp
    "neovim/nvim-lspconfig", -- lspconfig
    "onsails/lspkind-nvim", -- lspkind (VS pictograms)
    "hrsh7th/cmp-cmdline", -- :Command completions
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {"rafamadriz/friendly-snippets"}, -- Snippets
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        -- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
      end
    }, {"saadparwaiz1/cmp_luasnip", enabled = true}
  },
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")

    -- Display virtual text to indicate snippet has more nodes
    luasnip.config.setup({
      ext_opts = {
        [types.choiceNode] = {
          active = {virt_text = {{"⇥", "GruvboxRed"}}}
        },
        [types.insertNode] = {
          active = {virt_text = {{"⇥", "GruvboxBlue"}}}
        }
      }
    })

    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
          end, {"i", "s"})
      }),
      sources = cmp.config.sources({
        {name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 70,
          show_labelDetails = true
        })
      }
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        }, {
          { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    local lspconfig = require("lspconfig")

    -- All languages: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    -- Python: brew install pyright
    lspconfig["pyright"].setup {}

    -- Rust
    lspconfig["rust_analyzer"].setup {}

    -- Go: go install golang.org/x/tools/gopls@latest
    lspconfig["gopls"].setup {}
  end
}
