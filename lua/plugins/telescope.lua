local telescope_setup = function()
    local telescope = require("telescope")
    local setkeymap = require("utils").setkeymap

    --- Telescope configuration ---
    local options = {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules", "venv" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            mappings = {
                n = { ["q"] = require("telescope.actions").close },
            }
        },
        extensions_list = { "fzf", "live_grep_args" },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            },
            live_grep_args = {
                auto_quoting = true, -- enable/disable auto-quoting
            }
        }
    }
    local lga_actions = require("telescope-live-grep-args.actions")
    options["extensions"]["live_grep_args"]["mappings"] = { -- extend mappings
        i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            -- freeze the current list and start a fuzzy search in the frozen list
            ["<C-space>"] = require("telescope.actions").to_fuzzy_refine,
        },
    }
    telescope.setup(options)
    for _, ext in ipairs(options.extensions_list) do
        telescope.load_extension(ext)
    end
    local lga = require("telescope").extensions.live_grep_args
    local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
    setkeymap("n", "<Leader>fw", lga.live_grep_args, "Live grep", {})
    setkeymap("n", "<Leader>fcw", lga_shortcuts.grep_word_under_cursor, "Grep string under cursor", {})
    setkeymap("n", "<Leader>fvs", lga_shortcuts.grep_visual_selection, "Grep visual selection", {})
end


return {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    tag = "0.1.6",
    keys = {
        -- Files
        {
            "<C-p>",
            function()
                -- If error occurs in `git_files` then call normal find_files function
                -- This handles the case when we do ctrl-p in a non-git directory.
                local builtin = require("telescope.builtin")
                if not pcall(builtin.git_files, { show_untracked = true }) then
                    builtin.find_files()
                end
            end,
            "n",
            desc = "Find Git files if in a repo, else find directory files",
        },
        {
            "<Leader>ff",
            function()
                require("telescope.builtin").find_files({ no_ignore = true })
            end,
            "n",
            desc = "Find files",
        },

        {
            "<Leader>fa",
            function()
                require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
            end,
            "n",
            desc = "Find all files including hidden abd ignored",
        },
        { "<Leader>fb",  require("telescope.builtin").buffers,        "n", desc = "Show buffers", },
        {
            "<Leader>fo",
            function()
                require("telescope.builtin").oldfiles({ only_cwd = true })
            end,
            "n",
            desc = "Show previously opened files",
        },

        ------ Searching ------
        { "<Leader>lfh", require("telescope.builtin").search_history, "n", desc = "Grep history" },
        ------ Registers ------
        { "<Leader>lr",  require("telescope.builtin").registers,      "n", desc = "List registers" },

        ------ LSP ------
        -- See current buffers"s diagnostics
        {
            "<Leader>ld",
            function()
                require("telescope.builtin").diagnostics({ bufnr = 0 })
            end,
            "n",
            desc = "List buffer diagnostics",
        },
        -- See project diagnostics
        { "<Leader>lpd", require("telescope.builtin").diagnostics, "n", desc = "List project diagnostics" },

    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" }
    },
    config = function()
        telescope_setup()
    end
}
