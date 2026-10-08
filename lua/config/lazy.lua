-- lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim plugins here
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- Go: gopls, goimports/gofumpt, delve debugging, neotest-golang
    { import = "lazyvim.plugins.extras.lang.go" },
    -- Tests (<leader>t…) and debugging (<leader>d…), shared by Go and Swift
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.dap.core" },
    -- Completion: nvim-cmp instead of LazyVim's default (blink)
    { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
    -- GitHub PRs/issues and code reviews inside Neovim (octo.nvim)
    { import = "lazyvim.plugins.extras.util.octo" },

    -- Load the 'plugins' module where you define your plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git version
  },
  install = { colorscheme = { "catppuccin-macchiato", "habamax" } },
  -- No plugin in this config requires luarocks, and the hererocks bootstrap
  -- fails (`:checkhealth lazy` reports luarocks/lua 5.1 not installed).
  -- Disabling it removes the error instead of installing an unused toolchain.
  rocks = { hererocks = false },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
