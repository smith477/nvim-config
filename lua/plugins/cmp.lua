-- nvim-cmp comes from LazyVim's coding.nvim-cmp extra (see config/lazy.lua).
-- These are only your extra keys on top of its defaults.
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback() -- LazyVim's snippet jump
        end
      end, { "i", "s" }),
    })
  end,
}
