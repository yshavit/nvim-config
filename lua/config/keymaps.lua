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

-- Map ; to $ (end of line) in normal and visual mode
map("n", ";", "$", { desc = "Go to end of line" })
map("v", ";", "$", { desc = "Go to end of line" })

-- In insert mode, Alt+- types an em dash
vim.keymap.set("i", "<M-->", "—", { desc = "Insert em dash" })

-- Select All
map("n", "<C-a>", "ggVG", { desc = "Select All" })
map("i", "<C-a>", "<ESC>ggVG", { desc = "Select All" })
map("v", "<C-a>", "<ESC>ggVG", { desc = "Select All" })

-- Select All and Yank to clipboard
map("n", "<C-a>y", ":%y+<CR>", { desc = "Yank entire buffer" })
map("i", "<C-a>y", "<ESC>:%y+<CR>", { desc = "Yank entire buffer" })
map("v", "<C-a>y", "<ESC>:%y+<CR>", { desc = "Yank entire buffer" })
map("c", "<C-a>y", "<C-c>:%y+<CR>", { desc = "Yank entire buffer" })
