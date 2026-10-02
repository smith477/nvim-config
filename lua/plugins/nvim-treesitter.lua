-- Go parsers come from LazyVim's lang.go extra; Swift has no LazyVim extra.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "swift" } },
  },
}
