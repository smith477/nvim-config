return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {},
      },
    },
  },
  
  {
    "neovim/nvim-lspconfig",
    ft = "swift",
    config = function()
      local lspconfig = require("lspconfig")
      
      lspconfig.sourcekit.setup({
        cmd = { vim.fn.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
        filetypes = { "swift" },
        root_dir = function()
          return vim.fn.getcwd()
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
      },
    },
  },
}
