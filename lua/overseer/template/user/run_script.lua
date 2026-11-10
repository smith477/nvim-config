-- From stevearc/overseer.nvim doc/tutorials.md ("Run a file on save").
-- TypeScript uses `tsx`, the same runner LazyVim's lang.typescript extra
-- picks for nvim-dap (tsx, otherwise ts-node).
return {
  name = "run script",
  builder = function()
    local file = vim.fn.expand("%:p")
    local cmd = { file }
    if vim.bo.filetype == "go" then
      cmd = { "go", "run", file }
    elseif vim.bo.filetype == "python" then
      cmd = { "python", file }
    elseif vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
      cmd = { "tsx", file }
    end
    return {
      cmd = cmd,
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "sh", "python", "go", "typescript", "typescriptreact" },
  },
}
