return {
  "epwalsh/obsidian.nvim",
  version = "*", -- Use latest release
  lazy = true,
  ft = "markdown", -- Only load for markdown files

  -- Dependencies
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- Configuration
  opts = {
    workspaces = {
      {
        name = "mindblowers",
        path = "~/Documents/Dusan's Mindblowers",
      },
    },

    -- Optional: Daily notes
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
    },

    -- Optional: Completion settings
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },

  -- Keybindings
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note" },
    { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch notes" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Open today's note" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Open yesterday's note" },
  },
}
