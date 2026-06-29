-- -- Auto-start profiling on startup
-- vim.cmd([[
--   profile start ~/.cache/nvim/startup.log
--   profile file *
--   profile func *
-- ]])

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.commands") -- my custom commands

vim.opt.conceallevel = 1
