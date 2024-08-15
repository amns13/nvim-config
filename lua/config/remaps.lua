-- Set space as the leader key
local setkeymap = require("utils").setkeymap
vim.g.mapleader = " "

setkeymap('i', 'jk', '<Esc>', "Escape", {})

-- Open Netrw (:Explore)
setkeymap("n", "<leader>e", vim.cmd.Ex, "Open Explorer", {})

-- Move selected block up/down in visual mode
setkeymap("v", "J", ":m '>+1<CR>gv=gv", "Move selected block up", {})
setkeymap("v", "K", ":m '<-2<CR>gv=gv", "Move selected block down", {})

-- Set highlight on search, but clear on pressing <Esc> in normal mode
setkeymap('n', '<Esc>', '<cmd>nohlsearch<CR>', "Clear highlights", {})

-- Keep cursor in middle on Ctrl-d and Ctrl-u
setkeymap("n", "<C-d>", "<C-d>zz", "C-d and move to middle of screen", {})
setkeymap("n", "<C-u>", "<C-u>zz", "C-u and move to middle of screen", {})

-- Keep cusor in the middle while searching and unfold text if folded
setkeymap("n", "n", "nzzzv", "Go to next match, move to middle of screen, unfold", {})
setkeymap("n", "N", "Nzzzv", "Go to prev match, move to middle of screen, unfold", {})

-- Paste w/o copying the deleted text in clipboard register.
setkeymap("x", "<leader>p", "\"_dP", "Paste without yanking replaces text", {})

-- Copy to system clipboard
-- Note: A clipboard provider must be installed. Recommendation: `xclip`
-- NOT Using this because it hinders my workflow
-- setkeymap("n", "<leader>y", "\"+y", {})
-- setkeymap("v", "<leader>y", "\"+y", {})
-- setkeymap("n", "<leader>Y", "\"+y", {})

-- Delete w/o copying, i.e., delete and copy to void register
setkeymap("n", "<leader>d", "\"_d", "Delete without yanking", {})
setkeymap("v", "<leader>d", "\"_d", "Delete without yanking", {})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
setkeymap('n', '<C-h>', '<C-w><C-h>', "Move focus to the left window", {})
setkeymap('n', '<C-l>', '<C-w><C-l>', "Move focus to the right window", {})
setkeymap('n', '<C-j>', '<C-w><C-j>', "Move focus to the lower window", {})
setkeymap('n', '<C-k>', '<C-w><C-k>', "Move focus to the upper window", {})
