-- Catppuccin Macchiato everywhere (kitty, tmux, fzf, gh-dash, git diffs match).
-- Other flavors: "catppuccin-latte", "catppuccin-frappe", "catppuccin-mocha".
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "macchiato",
      -- Under kitty, Catppuccin shifts every colour one shade (#24273a → #24273b) so kitty
      -- can't make Neovim see-through. We want see-through: kitty.conf makes the exact
      -- Catppuccin backgrounds transparent (transparent_background_colors), so keep them exact.
      kitty = false,
    },
  },
}
