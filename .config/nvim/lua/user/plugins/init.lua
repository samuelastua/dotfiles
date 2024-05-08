return {
    -- automatically adjusts 'shiftwidth' and 'expandtab'
    -- dont like this plugin but keeping here just in case
    'tpope/vim-sleuth',
    --  ^^^
    "eandrju/cellular-automaton.nvim",
    'ryanoasis/vim-devicons',
    {
        "folke/zen-mode.nvim",
        opts = {},
        config = function()
            vim.keymap.set("n", "<leader>z", ":ZenMode<CR>" )
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },
    {
        "prettier/vim-prettier",
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
        variant = "main",
        config = function()
            require('rose-pine').setup({
                styles = {
                    transparency = true,
                }
            })
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enable = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
}
