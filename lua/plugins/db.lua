-- return {
--     "kristijanhusak/vim-dadbod-ui",
--     dependencies = {
--         { "tpope/vim-dadbod", lazy = true },
--         { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
--     },
--     cmd = {
--         "DBUI",
--         "DBUIToggle",
--         "DBUIAddConnection",
--         "DBUIFindBuffer",
--     },
--     init = function()
--         -- Your DBUI configuration
--         vim.g.db_ui_use_nerd_fonts = 1
--         vim.g.dbs = {
--             -- archlinux_local = "postgresql://archlinux:archlinux@localhost:5432/"
--             archlinux_local = "postgres://archlinux:archlinux@localhost:5432/"
--         }
--     end,
-- }

return {
    { "tpope/vim-dadbod", }
}


-- return {
--   'kristijanhusak/vim-dadbod-ui',
--   dependencies = {
--     { 'tpope/vim-dadbod', lazy = true },
--     { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
--   },
--   cmd = {
--     'DBUI',
--     'DBUIToggle',
--     'DBUIAddConnection',
--     'DBUIFindBuffer',
--   },
--   init = function()
--     -- Your DBUI configuration
--     vim.g.db_ui_use_nerd_fonts = 1
--   end,
-- }
