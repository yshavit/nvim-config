return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.WinSeparator = { fg = "#4a148c", bg = c.bg }
        hl.LineNrBelow = { fg = "#684d8a" } -- uses tokyonight's gutter foreground
        hl.LineNrAbove = { fg = "#684d8a" }
        hl.CursorLineNr = { fg = "#b24cd4", bold = true }
        hl.RenderMarkdownCode = { bg = '#2b3060' }
      end,
    },
  },
}
