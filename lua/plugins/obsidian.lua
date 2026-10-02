-- Edit the Obsidian vault from Neovim. Community-maintained fork of
-- epwalsh/obsidian.nvim (which stopped releasing in 2024).
--
-- Daily notes are CREATED in the Obsidian app, because the daily template is
-- a Templater script that only runs there. <leader>ot opens today's note if
-- it exists and otherwise says so, instead of creating a blank one.

local vault = vim.fn.expand("~/Documents/Dusan's Mindblowers")

local function open_today()
  local file = vault .. "/daily/" .. os.date("%Y-%m-%d") .. ".md"
  if vim.uv.fs_stat(file) then
    vim.cmd.edit(vim.fn.fnameescape(file))
  else
    vim.notify("No daily note yet — create it in Obsidian (your template runs there).", vim.log.levels.WARN)
  end
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = "Obsidian",
  opts = {
    legacy_commands = false,
    workspaces = { { name = "mindblowers", path = vault } },
    daily_notes = { folder = "daily", date_format = "%Y-%m-%d" },
  },
  keys = {
    { "<leader>ot", open_today, desc = "Today's note" },
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
    { "<leader>oo", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>of", "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
  },
}
