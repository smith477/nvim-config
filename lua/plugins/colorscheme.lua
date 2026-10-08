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
    },
  },
}
