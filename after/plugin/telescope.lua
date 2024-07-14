local builtin = require('telescope.builtin')

------ Files opener ------
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({ no_ignore = true })
end)
vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end)
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', function()
    builtin.git_files({ show_untracked = true })
end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fo', function()
    builtin.oldfiles({ only_cwd = true })
end)


------ Searching ------
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fcw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>lfh', builtin.search_history, {})
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ")})
-- end)

------ Registers ------
vim.keymap.set('n', '<leader>lr', builtin.registers, {})

------ LSP ------
-- See current buffers's diagnostics
vim.keymap.set('n', '<leader>lbd', function()
    builtin.diagnostics({ bufnr = 0 })
end)
-- See project diagnostics
vim.keymap.set('n', '<leader>ld', builtin.diagnostics, {})
