local setkeymap = require("utils").setkeymap

return {
    {
        "stevearc/oil.nvim",
        -- dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup {
                columns = { "icon" },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                    ["<C-p>"] = false,
                    ["<M-h>"] = "actions.select_split",
                },
                view_options = {
                    show_hidden = true,
                },
            }

            -- Open parent directory in current window
            setkeymap("n", "<leader>e", "<CMD>Oil<CR>", "Open parent directory", {})

            -- Open parent directory in floating window
            setkeymap("n", "<leader>E", require("oil").toggle_float, "Open parent dir in floating", {})
        end,
    },
}
