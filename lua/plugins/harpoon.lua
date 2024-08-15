local setkeymap = require("utils").setkeymap

return {
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = { { "<leader>a", "<leader>th" } },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        setkeymap("n", "<leader>a", mark.add_file, "Add file to harpoon", {})
        setkeymap("n", "<leader>th", ui.toggle_quick_menu, "Toggle harpoon menu", {})

        -- Set <space>1..<space>5 be my shortcuts to moving to the files
        for _, idx in ipairs { 1, 2, 3, 4, 5 } do
            setkeymap(
                "n",
                string.format("<leader>%d", idx),
                function() ui.nav_file(idx) end,
                string.format("Go to harpooned file%d", idx),
                {}
            )
        end
    end,
}
