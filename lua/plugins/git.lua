local setkeymap = require("utils").setkeymap
local is_git_repo = require("utils").is_git_repo

local function enable_git_plugins()
    if is_git_repo() then
        return "BufEnter"
    end
    return nil
end

return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = enable_git_plugins(),
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local opts = { buffer = bufnr }

                -- Navigation
                setkeymap(
                    "n",
                    "]c",
                    function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end,
                    "Next change",
                    opts
                )

                setkeymap(
                    "n",
                    "[c",
                    function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end,
                    "Previous change",
                    opts)

                -- Actions
                setkeymap("n", "<leader>hs", gitsigns.stage_hunk, "Hunk stage", opts)
                setkeymap("n", "<leader>hr", gitsigns.reset_hunk, "Hunk reset", opts)
                setkeymap(
                    "v",
                    "<leader>hs",
                    function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                    "Hunk stage",
                    opts
                )
                setkeymap("v",
                    "<leader>hr",
                    function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                    "Hunk reset",
                    opts)
                setkeymap("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer", opts)
                setkeymap("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo staged hunk", opts)
                setkeymap("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer", opts)
                setkeymap("n", "<leader>hp", gitsigns.preview_hunk, "Hunk preview", opts)
                setkeymap("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, "Blame lines", opts)
                setkeymap("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle line blame", opts)
                setkeymap("n", "<leader>hd", gitsigns.diffthis, "Diff buffer", opts)
                setkeymap("n", "<leader>td", gitsigns.toggle_deleted, "Toggle deleted", opts)
            end

        }
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        lazy = true,
        event = enable_git_plugins(),
        config = true
    },
    {
        "tpope/vim-fugitive",
        lazy = true,
        event = enable_git_plugins(),
    },
}
