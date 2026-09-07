-- -- Auto-start profiling on startup
-- vim.cmd([[
--   profile start ~/.cache/nvim/startup.log
--   profile file *
--   profile func *
-- ]])

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.commands") -- my custom commands

-- Draw window separators as connected double lines. Separators always occupy
-- one screen row or column; these glyphs control their strokes and junctions.
vim.opt.fillchars:append({
  vert = "║",
  horiz = "═",
  horizup = "╩",
  horizdown = "╦",
  vertleft = "╣",
  vertright = "╠",
  verthoriz = "╬",
})

vim.opt.conceallevel = 1
