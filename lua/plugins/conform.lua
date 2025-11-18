return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = {}, -- Disable all formatters for Go; we'll use goimports
    },
  },
}
