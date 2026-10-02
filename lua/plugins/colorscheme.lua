return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula", -- Change to "catppuccin" to swap back
    },
  },
  -- Dracula theme
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1000,
    config = function()
      require("dracula").setup({
        -- Customize diff colors for better visibility
        overrides = {
          DiffAdd = { bg = "#2d4a2b", fg = "#a6e3a1" },
          DiffChange = { bg = "#3a3a4d", fg = "#89b4fa" },
          DiffDelete = { bg = "#4d2d2d", fg = "#f38ba8" },
          DiffText = { bg = "#4a4a6d", fg = "#cdd6f4" },
        },
      })
    end,
  },
  -- Catppuccin theme (kept for easy swapping)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
    },
  },
}
