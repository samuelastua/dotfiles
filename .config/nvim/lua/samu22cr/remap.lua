-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})


-- word wrapping
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- awesome remap for quick scripts
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>X", "<cmd>!chmod -x %<CR>", { silent = true })

-- move fast between buffers
vim.keymap.set("n", "<C-S-H>", "<C-w><left>", { silent = true })
vim.keymap.set("n", "<C-S-J>", "<C-w><down>", { silent = true })
vim.keymap.set("n", "<C-S-K>", "<C-w><up>", { silent = true })
vim.keymap.set("n", "<C-S-L>", "<C-w><right>", { silent = true })


-- to manipulate the CLIPBOARD selection (not the PRIMARY/current selection)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- yank to CLIPBOARD selection (for motions)
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- yank current line to CLIPBOARD selection

vim.keymap.set({"n", "v"}, "<leader>P", [["+p]]) -- put CLIPBOARD selection before cursor
vim.keymap.set("n", "<leader>P", [["+P]]) -- put CLIPBOARD selectio after cursor

-- browsing netrm like a chad
vim.keymap.set("n", "<leader>n", ":Ex<CR>")
vim.keymap.set("n", "<leader>m", ":Vex<CR>")
vim.keymap.set("n", "<leader>M", ":Hex<CR>")
