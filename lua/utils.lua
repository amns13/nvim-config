local M = {}

--- Utility function to set keymaps.
--- Using this to make description mandatory for whichkey
---@param mode
---@param lhs
---@param rhs
---@param desc
---@param opts
function M.setkeymap(mode, lhs, rhs, desc, opts)
    opts["desc"] = desc
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.is_git_repo()
    local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

return M
