return {
    "mbbill/undotree",
    lazy=true,
    keys = {
        {"<leader>u", vim.cmd.UndotreeToggle, desc="Toggle UndoTree"},
        {"<leader>U", vim.cmd.UndotreeFocus, desc="Focus UndoTree"}
    }
}
