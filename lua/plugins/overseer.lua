return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerOpen", "OverseerRun" },
  config = function()
    require("overseer").setup()
  end,
}
