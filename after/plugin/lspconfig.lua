-- Initialize mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Common lsp setup on_attach
local on_attach_common = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vdf", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vsh", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>vfm", function() vim.lsp.buf.format() end, opts)
end


-- Setup nvim lspconfig
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Ruff config (Python)
local on_attach_ruff = function(client, bufnr)
    on_attach_common(client, bufnr)
    client.server_capabilities.hoverProvider = false
end

lspconfig.ruff.setup {
    on_attach = on_attach_ruff,
    capabilities = capabilities
}

lspconfig.pyright.setup {
    on_attach = on_attach_common,
    capabilities = capabilities,
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                -- ignore = { '*' },
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "warning", -- or anything
                },
                typeCheckingMode = "basic",
            },
        },
    },
}

lspconfig.lua_ls.setup { on_attach = on_attach_common, capabilities = capabilities }
