return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Enter always dismisses completion and inserts a newline.
    opts.mapping["<CR>"] = cmp.mapping(function(fallback)
      cmp.abort()
      fallback()
    end)
    -- Shift+Tab accepts the selected item, or the first available suggestion.
    opts.mapping["<S-Tab>"] = cmp.mapping.confirm({ select = true })
  end,
}
