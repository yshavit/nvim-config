return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.WinSeparator = { fg = "#4a148c", bg = c.bg }
      end,
    },
  },
}
