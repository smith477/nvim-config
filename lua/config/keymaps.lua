-- Exit insert mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Close current buffer
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })

-- Open horizontal terminal at bottom
vim.keymap.set("n", "<leader>th", function()
  vim.cmd("below 15split | terminal")
end, { desc = "Terminal horizontal" })

-- Open vertical terminal on right
vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("vsplit | terminal")
end, { desc = "Terminal vertical" })

-- Split windows
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })

-- Ctrl+h/j/k/l between splits and tmux panes: lua/plugins/tmux-navigator.lua

-- Rename symbol (LazyVim's own key is <leader>cr)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Resize windows with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Equalize window sizes" })
vim.keymap.set("n", "<leader>|", "<C-w>|", { desc = "Maximize window width" })
vim.keymap.set("n", "<leader>_", "<C-w>_", { desc = "Maximize window height" })

-- Exit terminal mode with jk
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Format selected lines (visual mode) - Space + f + s
vim.keymap.set("v", "<leader>fs", function()
  vim.lsp.buf.format({ async = false })
end, { desc = "Format selection" })

-- Format entire file - Space + f + S
vim.keymap.set("n", "<leader>fS", function()
  vim.lsp.buf.format({ async = false })
end, { desc = "Format file" })

-- Smart line break for Swift
vim.keymap.set("n", "<leader>m", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local before = line:sub(1, col - 1)
  local after = line:sub(col)
  vim.api.nvim_set_current_line(before)
  vim.cmd('normal! o')
  vim.api.nvim_set_current_line(after)
end, { desc = "Break line at cursor" })
