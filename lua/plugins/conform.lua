local features = require("config.local-features")

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}

    -- Only configure Go formatter if Go feature is enabled
    if features.is_enabled("go") then
      opts.formatters_by_ft.go = {} -- Disable all formatters for Go; we'll use goimports
    end

    return opts
  end,
}
