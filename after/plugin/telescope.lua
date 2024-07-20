local telescope = require("telescope")
local builtin = require('telescope.builtin')
local lga = require("telescope").extensions.live_grep_args
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
local lga_actions = require("telescope-live-grep-args.actions")

--- KEY MAPS ---
------ Files opener ------
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ no_ignore = true })
end, { desc = "Find files" })

vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "Find all files including hidden abd ignored" })

vim.keymap.set('n', '<C-p>', function()
    -- If error occurs in `git_files` then call normal find_files function
    -- This handles the case when we do ctrl-p in a non-git directory.
    if not pcall(builtin.git_files, { show_untracked = true }) then
        builtin.find_files()
    end
end, { desc = "Find Git files if in a repo, else find directory files" })

vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Show buffers" })
vim.keymap.set('n', '<leader>fo', function()
    builtin.oldfiles({ only_cwd = true })
end, { desc = "Show previously opened files" })

------ Searching ------
vim.keymap.set('n', '<leader>fw', lga.live_grep_args, { desc = "Live grep" })
vim.keymap.set('n', '<leader>fcw', lga_shortcuts.grep_word_under_cursor, { desc = "Grep string under cursor" })
vim.keymap.set('n', '<leader>fvs', lga_shortcuts.grep_visual_selection, { desc = "Grep visual selection" })
vim.keymap.set('n', '<leader>lfh', builtin.search_history, { desc = "Grep history" })
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ")})
-- end)

------ Registers ------
vim.keymap.set('n', '<leader>lr', builtin.registers, {})

------ LSP ------
-- See current buffers's diagnostics
vim.keymap.set('n', '<leader>ld', function()
    builtin.diagnostics({ bufnr = 0 })
end, { desc = "List buffer diagnostics" })
-- See project diagnostics
vim.keymap.set('n', '<leader>lpd', builtin.diagnostics, { desc = "List project diagnostics" })


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
            -- define mappings, e.g.
            mappings = {         -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                    -- freeze the current list and start a fuzzy search in the frozen list
                    ["<C-space>"] = require("telescope.actions").to_fuzzy_refine,
                },
            },

        }
    }
}

telescope.setup(options)

for _, ext in ipairs(options.extensions_list) do
    telescope.load_extension(ext)
end
