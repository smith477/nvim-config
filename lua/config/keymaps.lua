-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit insert mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Open horizontal terminal at bottom
vim.keymap.set("n", "<leader>th", function()
  vim.cmd("below 15split | terminal")
end, { desc = "Terminal horizontal" })

-- Open vertical terminal on right
vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("vsplit | terminal")
end, { desc = "Terminal vertical" })

-- Exit terminal mode with jk
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })
