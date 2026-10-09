-- LazyVim's markdown extra sets heading.icons to {} so the # markers stay visible.
-- These icons replace them. The heading under the cursor still shows raw # while editing.
return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.markdown = {}
      return opts
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        icons = { "● ", "○ ", "◆ ", "◇ ", "▸ ", "▹ " },
        position = "overlay",
      },
    },
  },
}
