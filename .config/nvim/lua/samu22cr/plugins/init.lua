

return {
  -- automatically adjusts 'shiftwidth' and 'expandtab'
  'tpope/vim-sleuth',
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
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function ()
      require('rose-pine').setup({
        styles = {
          transparency = true
        }
      })
      vim.cmd("colorscheme rose-pine")
    end
   },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'rose-pine',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

}

