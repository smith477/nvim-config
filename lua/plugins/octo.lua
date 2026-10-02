-- octo.nvim comes from LazyVim's util.octo extra (see config/lazy.lua).
-- The extra turns on GitHub Projects (v2) support, which needs the
-- `read:project` token scope; PR reviews don't need it, so keep it off.
return {
  "pwntester/octo.nvim",
  opts = { default_to_projects_v2 = false },
}
