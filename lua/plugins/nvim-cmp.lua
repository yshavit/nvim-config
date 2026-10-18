return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Enter always dismisses completion and inserts a newline.
    opts.mapping["<CR>"] = cmp.mapping(function(fallback)
      cmp.abort()
      fallback()
    end)
    -- Shift+Tab accepts the selected item, or the first available suggestion.
    opts.mapping["<C-Space>"] = cmp.mapping.confirm({ select = true })

    table.insert(opts.sources, { name = "emoji" })
  end,
}
