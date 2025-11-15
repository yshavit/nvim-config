return {
  "Mr-LLLLL/interestingwords.nvim",
  event = "VeryLazy", -- load after startup is complete
  config = function()
    require("interestingwords").setup({})
  end,
  keys = {
    -- Override LazyVim's <Leader>K mapping, which shows the man page for the cursor's word
    {
      "<Leader>K",
      "<cmd>lua require('interestingwords').cancel_all_highlight()<cr>",
      desc = "Clear interesting word highlights",
    },
  },
}
