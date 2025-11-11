return {
  "Mr-LLLLL/interestingwords.nvim",
  lazy = false, -- make sure it loads immediately
  config = function()
    require("interestingwords").setup({}) -- plugin sets up its defaults
  end,
}
