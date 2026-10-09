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

-- Keep the title the user typed, including spaces, so new files match notes
-- created in the Obsidian app. Fall back to a unique id when the title is empty.
local function title_filename(title, dir)
  local name = vim.trim(title or "")
  name = name:gsub('[<>:"/\\|?*%z]', "")
  name = vim.trim(name)
  if name == "" then
    return require("obsidian.builtin").zettel_id()
  end
  if not dir then
    return name
  end

  local Path = require("obsidian.path")
  local base_dir = Path.new(dir)
  local candidate = name
  local idx = 2
  while (base_dir / candidate):with_suffix(".md", true):exists() do
    candidate = string.format("%s %d", name, idx)
    idx = idx + 1
  end
  return candidate
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = "Obsidian",
  opts = {
    legacy_commands = false,
    workspaces = { { name = "mindblowers", path = vault } },
    notes_subdir = "0. Inbox",
    new_notes_location = "notes_subdir",
    note_id_func = title_filename,
    -- This vault's notes do not use the plugin's id/aliases/tags block.
    -- Leave existing properties alone when a note is saved.
    frontmatter = { enabled = false },
    link = { auto_update = true },
    attachments = { folder = "3. Resources/Assets" },
    daily_notes = { folder = "daily", date_format = "%Y-%m-%d" },
    -- Save from Neovim syncs the vault without the desktop app. A continuous
    -- second client is not started automatically, so it does not run beside
    -- the desktop app. Use :Obsidian sync start only while that app is closed.
    sync = {
      enabled = true,
      trigger = "on_write",
      device_name = "neovim",
      configs = {},
    },
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
