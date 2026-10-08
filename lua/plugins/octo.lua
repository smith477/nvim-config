-- octo.nvim comes from LazyVim's util.octo extra (see config/lazy.lua).
-- The extra turns on GitHub Projects (v2) support, which needs the
-- `read:project` token scope; PR reviews don't need it, so keep it off.

-- Two GitHub accounts: `gh` is logged in to both, but some private repos need the
-- second ("work") one. Octo gives `gh` only a short list of environment variables
-- (GH_TOKEN is not on it), so pass the token on explicitly:
--   • if GH_TOKEN is set (e.g. by a PR dashboard launching Neovim) use that
--   • else, in a folder whose path contains $WORK_PATH_MATCH, ask gh once for the
--     token of the account $WORK_GH_USER
-- Set both variables in your shell config, e.g.  export WORK_GH_USER=<github login>
-- and  export WORK_PATH_MATCH=<folder name keyword>.  If they're unset, or you're
-- anywhere else, Octo keeps using whichever account `gh` has active.
local work_token
local function gh_env()
  local token = vim.env.GH_TOKEN
  local user, match = vim.env.WORK_GH_USER, vim.env.WORK_PATH_MATCH
  if (not token or token == "") and user and user ~= "" and match and match ~= ""
      and vim.fn.getcwd():lower():find(match:lower(), 1, true) then
    if work_token == nil then
      local out = vim.trim(vim.fn.system({ "gh", "auth", "token", "--user", user }))
      work_token = (vim.v.shell_error == 0 and out ~= "") and out or false
    end
    token = work_token or nil
  end
  if token and token ~= "" then
    return { GH_TOKEN = token }
  end
  return {}
end

-- ssh_aliases: remotes like git@github.com-personal:… (an ~/.ssh/config
-- alias) are really github.com, where gh is logged in.
return {
  "pwntester/octo.nvim",
  opts = {
    default_to_projects_v2 = false,
    gh_env = gh_env,
    ssh_aliases = { ["github.com-personal"] = "github.com" },
  },
}
