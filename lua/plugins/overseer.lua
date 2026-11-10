return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerOpen", "OverseerRun", "OverseerToggle", "WatchRun" },
  keys = {
    -- Same key LazyVim uses to run the current Lua buffer (<localleader>r).
    {
      "<localleader>r",
      function()
        local overseer = require("overseer")
        overseer.run_task({ name = "run script" }, function(task)
          if task then
            task:open_output("vertical")
          else
            vim.notify("Run not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
          end
        end)
      end,
      desc = "Run TypeScript file",
      ft = { "typescript", "typescriptreact" },
    },
  },
  config = function()
    require("overseer").setup()

    -- overseer tutorial: run the file, show output, re-run on save.
    vim.api.nvim_create_user_command("WatchRun", function()
      local overseer = require("overseer")
      overseer.run_task({ name = "run script", autostart = false }, function(task)
        if task then
          task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
          task:start()
          task:open_output("vertical")
        else
          vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
        end
      end)
    end, {})
  end,
}
