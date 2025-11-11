-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set

-- Map Tab to ^ (first non-blank character) in normal and visual mode
map("n", "<Tab>", "^", { desc = "Go to first non-blank character" })
map("v", "<Tab>", "^", { desc = "Go to first non-blank character" })

-- Move by display lines instead of actual lines
map({ "n", "v" }, "j", "gj", { desc = "Down (display line)" })
map({ "n", "v" }, "k", "gk", { desc = "Up (display line)" })
map({ "n", "v" }, "0", "g0", { desc = "Start of display line" })
map({ "n", "v" }, "$", "g$", { desc = "End of display line" })

-- Map ; to $ (end of line) in normal and visual mode
map("n", ";", "g$", { desc = "Go to end of line" })
map("v", ";", "g$", { desc = "Go to end of line" })

-- In insert mode, Alt+- types an em dash
vim.keymap.set("i", "<M-->", "—", { desc = "Insert em dash" })
