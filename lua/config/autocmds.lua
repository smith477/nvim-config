-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Override Dracula theme diff colors to make them more readable
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "dracula",
  callback = function()
    -- Make diff green darker and more readable
    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#1e3a1e', fg = '#50fa7b' })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#3a3a1e', fg = '#f1fa8c' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#3a1e1e', fg = '#ff5555' })
    vim.api.nvim_set_hl(0, 'DiffText', { bg = '#4a4a1e', fg = '#f1fa8c', bold = true })
  end,
})
