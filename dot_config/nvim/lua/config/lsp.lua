local on_attach = function(_, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", function()
    vim.lsp.buf.declaration()
  end, opts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set("n", "gi", function()
    vim.lsp.buf.implementation()
  end, opts)
  -- vim.keymap.set("n", "<C-k>", function()
  -- 	vim.lsp.buf.signature_help()
  -- end, opts)
  vim.keymap.set("n", "gt", function()
    vim.lsp.buf.type_definition()
  end, opts)
  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "<leader>af", function()
    vim.lsp.buf.formatting()
  end, opts)
  vim.keymap.set("n", "<leader>", function()
    vim.lsp.buf.formatting()
  end, opts)
  vim.keymap.set("n", "<leader>e", function()
    vim.diagnostic.open_float()
  end, opts)
end

-- Set up lspconfig.
local cmp = require("cmp_nvim_lsp")
local capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = { on_attach = on_attach, capabilities = capabilities }
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- Default handler (optional)
    lspconfig[server_name].setup {
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
    }
  end,

  ['lua_ls'] = function()
    lspconfig.lua_ls.setup({
      on_attach = opts.on_attach,
      settings = { Lua = { diagnostics = { globals = { "vim", "use" } } } }
    })
  end,

  ['tsserver'] = function()
    lspconfig.tsserver.setup({
      on_attach = opts.on_attach,
      init_options = {
        preferences = { importModuleSpecifierPreference = "non-relative" }
      }
    })
  end,
})
