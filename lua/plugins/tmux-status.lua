-- Show build/test state on this Neovim's tmux tab (tmux option @task, drawn
-- by ~/dotfiles/tmux/tmux.conf):  🔨 building · 🧪 testing · ✅ passed · ❌ failed
-- Swift: xcodebuild.nvim events. Go: a neotest consumer. Outside tmux: nothing.

local pane = vim.env.TMUX_PANE

local function set_task(icon)
  if not pane then
    return
  end
  local cmd = icon and { "tmux", "-u", "set", "-w", "-t", pane, "@task", icon }
    or { "tmux", "-u", "set", "-wu", "-t", pane, "@task" }
  vim.system(cmd)
end

return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    optional = true,
    init = function()
      if not pane then
        return
      end
      local group = vim.api.nvim_create_augroup("tmux_task_status", { clear = true })
      local function on(event, fn)
        vim.api.nvim_create_autocmd("User", { group = group, pattern = event, callback = fn })
      end
      on("XcodebuildBuildStarted", function()
        set_task("🔨")
      end)
      on("XcodebuildBuildFinished", function(ev)
        local d = ev.data or {}
        if d.cancelled then
          set_task(nil)
        elseif not d.success then
          set_task("❌")
        elseif not d.forTesting then -- when testing, the test result follows
          set_task("✅")
        end
      end)
      on("XcodebuildTestsStarted", function()
        set_task("🧪")
      end)
      on("XcodebuildTestsFinished", function(ev)
        local d = ev.data or {}
        if d.cancelled then
          set_task(nil)
        else
          set_task((d.failedCount or 0) > 0 and "❌" or "✅")
        end
      end)
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = function()
          set_task(nil)
        end,
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      opts.consumers = opts.consumers or {}
      opts.consumers.tmux_status = function(client)
        client.listeners.run = function()
          set_task("🧪")
        end
        client.listeners.results = function(_, results, partial)
          if partial then
            return
          end
          for _, result in pairs(results) do
            if result.status == "failed" then
              return set_task("❌")
            end
          end
          set_task("✅")
        end
        return {}
      end
    end,
  },
}
