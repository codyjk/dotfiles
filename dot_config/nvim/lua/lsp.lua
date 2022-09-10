local on_attach = function(_, buffer)
	local opts = { noremap = true, silent = true, buffer = buffer }
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts)
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("n", "<C-k>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "gt", function()
		vim.lsp.buf.type_definition()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>af", function()
		vim.lsp.buf.formatting()
	end, opts)
end

local opts = { on_attach = on_attach }
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- Default handler (optional)
        lspconfig[server_name].setup {
            on_attach = opts.on_attach,
        }
    end,

    ['sumneko_lua'] = function()
        lspconfig.sumneko_lua.setup({
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

