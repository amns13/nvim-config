-- Initialize lazy. Copied from the github readme
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make' },
            { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" } }
    },

    -- Theme: rosepine
    { "rose-pine/neovim",  name = "rose-pine" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },

    -- Undotree
    { "mbbill/undotree" },

    -- Git fugitive
    { "tpope/vim-fugitive" },

    -- Mason
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "pyright",
                "ruff",
                "lua-language-server",
                "debugpy"
            }
        }
    },

    -- LSP
    { "neovim/nvim-lspconfig",  dependencies = { "nvimtools/none-ls.nvim" } },

    -- Neogen
    {
        "danymat/neogen",
        config = true
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip"
        }
    },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },

    -- Gitsigns
    { "lewis6991/gitsigns.nvim" },

    -- vim-tmux-navigator
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- DAP: Debug Adaptor Protocol
    {
        "mfussenegger/nvim-dap",
        config = function(_, opts)
            vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },

    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
        config = function()
            vim.keymap.set("n", "<leader>dpr", function()
                require("dap-python").test_method()
            end)
        end
    },

    -- Whichkey
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    -- Copilot
    -- Keeping this for reference
    -- { "github/coplilot.nvim", lazy=false}
    -- Adding the below in after/copilots.lua
    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_assume_mapped = true
    -- vim.api.nvim_set_keymap("i", "<F2>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    -- vim.api.nvim_set_keymap("i", "<F3>", 'copilot#Next()', { silent = true, expr = true })
    -- vim.api.nvim_set_keymap("i", "<F4>", 'copilot#Previous()', { silent = true, expr = true })

    -- Indent blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = { scope = { enabled = false } }
    },

    -- Code context
    { "nvim-treesitter/nvim-treesitter-context", },

    -- Cspell
    -- { "davidmh/cspell.nvim" }

}

require("lazy").setup(plugins, opts)
