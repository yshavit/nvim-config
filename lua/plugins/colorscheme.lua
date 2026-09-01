return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.WinSeparator = { fg = "#4a148c", bg = c.bg }
        hl.LineNrBelow = { fg = "#913a73" }
        hl.LineNrAbove = { fg = "#4f7188" }
        hl.CursorLineNr = { fg = "#d06be8", bg = "#332443", bold = true }
        hl.RenderMarkdownCode = { bg = "#2b3060" }
      end,
    },
  },
}
