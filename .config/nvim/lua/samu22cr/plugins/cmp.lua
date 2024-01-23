return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
    } -- this is equalent to setup({}) function
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      "danymat/neogen",
    },
    config = function()

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local neogen = require('neogen')

      --[[ autopairs ]]
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require("cmp").event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true
      })


      --[[ snippets ]]
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      --[[ auto-completion ]]
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif neogen.jumpable() then
              neogen.jump_next()
            else
              fallback()
            end
          end, { 'i', 's' }),
          -- ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif neogen.jumpable() then
              neogen.jump_prev()
            else
              fallback()
            end
          end, { 'i', 's' }),
          -- ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif neogen.jumpable() then
              neogen.jump_next()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            ---@diagnostic disable-next-line: param-type-mismatch
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end
  },
}
