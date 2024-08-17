local setkeymap = require("utils").setkeymap

local on_attach_common = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    setkeymap("n", "gd", vim.lsp.buf.definition, "LSP definition", opts)
    setkeymap("n", "K", vim.lsp.buf.hover, "LSP hover", opts)
    setkeymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbol", opts)
    setkeymap("n", "<leader>vdf", vim.diagnostic.open_float, "Floating diagnostic", opts)
    setkeymap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic", opts)
    setkeymap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic", opts)
    setkeymap("n", "<leader>vca", vim.lsp.buf.code_action, "LSP code action", opts)
    setkeymap("n", "<leader>vrr", vim.lsp.buf.references, "LSP references", opts)
    setkeymap("n", "<leader>vrn", vim.lsp.buf.rename, "LSP rename", opts)
    setkeymap("n", "<leader>vsh", vim.lsp.buf.signature_help, "LSP signature help", opts)
    setkeymap("n", "<leader>vfm", vim.lsp.buf.format, "LSP format", opts)
end

return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "pyright",
                "ruff",
                "lua-language-server",
                "debugpy"
            },
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            cmp.setup.filetype({ "sql" }, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" }
                }
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "nvimtools/none-ls.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
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
        end
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", "Toggle breakpoint" }
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },

    {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        ft = "python",
        dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
        config = function()
            setkeymap("n", "<leader>dpr", function() require("dap-python").test_method() end, "Debug test", {})
            require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        end
    },

    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        }
    },
    {
        "nvim-neotest/neotest-python",
        lazy = true,
        ft = { "python", },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        args = { "--log-level", "DEBUG" },
                        -- runner = "pytest",
                        runner = "unittest",
                    })
                }
            })
        end
    }
}
