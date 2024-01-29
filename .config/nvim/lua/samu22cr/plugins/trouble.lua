return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { },
    config = function()
        vim.keymap.set("n", "<leader>o", function() require("trouble").toggle("workspace_diagnostics") end,
            { desc = "Open document trouble (diagnostics)" })
        vim.keymap.set("n", "<leader>ow", function() require("trouble").toggle("workspace_diagnostics") end,
            { desc = "Open workspace trouble (diagnostics)" })
    end
}
