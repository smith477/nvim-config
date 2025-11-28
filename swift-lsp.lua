return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      sourcekit = {
        cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
        filetypes = { "swift", "objective-c", "objective-cpp" },
        root_dir = function(filename, _)
          local util = require("lspconfig.util")
          return util.root_pattern("buildServer.json")(filename)
            or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
            or util.root_pattern("Package.swift")(filename)
            or util.find_git_ancestor(filename)
        end,
      },
    },
  },
}
