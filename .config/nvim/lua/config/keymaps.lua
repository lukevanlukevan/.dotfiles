-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })

-- time to lock in:

vim.keymap.set("n", "<Left>", ':echoe "Use h"<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ':echoe "Use l"<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Up>", ':echoe "Use k"<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ':echoe "Use j"<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ii", ":lua Snacks.image.hover()<cr>", { silent = true })
