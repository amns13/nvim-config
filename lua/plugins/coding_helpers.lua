return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "InsertEnter",
        main = "ibl",
        config = { scope = { enabled = false } }
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        event = "InsertEnter"
    },
    {
        "danymat/neogen",
        config = true,
        lazy = true,
        event = "InsertEnter",
        opts = {
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings"
                    }
                }
            }
        }
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
}
