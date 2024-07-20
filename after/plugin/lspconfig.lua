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

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, remap = false, desc = "LSP definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = "LSP hover" })
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { buffer = bufnr, remap = false, desc =
    "Workspace symbol" })
    vim.keymap.set("n", "<leader>vdf", vim.diagnostic.open_float, { buffer = bufnr, remap = false, desc =
    "Floating diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = "Next diagnostic" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = "Previous diagnostic" })
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { buffer = bufnr, remap = false, desc = "LSP code action" })
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { buffer = bufnr, remap = false, desc = "LSP references" })
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "LSP rename" })
    vim.keymap.set("n", "<leader>vsh", vim.lsp.buf.signature_help, { buffer = bufnr, remap = false, desc =
    "LSP signature help" })
    vim.keymap.set("n", "<leader>vfm", vim.lsp.buf.format, { buffer = bufnr, remap = false, desc = "LSP format" })
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
lspconfig.jsonls.setup { on_attach = on_attach_common, capabilities = capabilities }
