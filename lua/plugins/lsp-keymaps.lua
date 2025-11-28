return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Add keybindings when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          
          -- Only set keymaps if capabilities exist
          if client.server_capabilities.definitionProvider then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
          end
          
          if client.server_capabilities.declarationProvider then
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
          end
          
          if client.server_capabilities.referencesProvider then
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
          end
          
          if client.server_capabilities.implementationProvider then
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
          end
          
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        end,
      })
      
      -- Ensure gopls starts for Go files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local clients = vim.lsp.get_active_clients({ bufnr = 0 })
          local has_gopls = false
          for _, client in ipairs(clients) do
            if client.name == "gopls" then
              has_gopls = true
              break
            end
          end
          
          if not has_gopls then
            vim.cmd("LspStart gopls")
          end
        end,
      })
      
      return opts
    end,
  },
}
