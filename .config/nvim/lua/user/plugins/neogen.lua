return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  version = "*",
  config = function ()
    local neogen = require("neogen")
    neogen.setup({
      snippet_engine = 'luasnip',
    })
    neogen:setup()

    vim.keymap.set('n', "<leader>dc", function ()
      neogen.generate({
        type = 'class'
      });
    end)

    vim.keymap.set('n', "<leader>df", function ()
      neogen.generate({
        type = 'func'
      });
    end)

    vim.keymap.set('n', "<leader>dt", function ()
      neogen.generate({
        type = 'type'
      });
    end)

    vim.keymap.set('n', "<leader>da", function ()
      neogen.generate({
        type = 'file'
      });
    end, { silent = true, noremap = true })

  end,
}
