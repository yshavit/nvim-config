-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set

-- Map Tab to ^ (first non-blank character) in normal and visual mode, using screen lines (factoring in soft wrapping)
map("n", "<Tab>", "^", { desc = "Go to first non-blank character" })
map("v", "<Tab>", "^", { desc = "Go to first non-blank character" })
-- ...and shift-Tab to `0`
map("n", "<S-Tab>", "0", { desc = "Go to beginning of line" })
map("v", "<S-Tab>", "0", { desc = "Go to beginning of line" })

-- Map ; to $ (end of line) in normal and visual mode
map("n", ";", "$", { desc = "Go to end of line" })
map("v", ";", "$", { desc = "Go to end of line" })

-- Manually insert quote pairs, since I've disabled them in mini-pairs.lua
-- For now, I'm disabling these altogether, and will just type quotes manually. I'm keeping these in case I want them later.
-- map("i", "'' ", "''<Left>", { desc = "Insert '' pair" })
-- map("i", '"" ', '""<Left>', { desc = 'Insert "" pair' })
-- map("i", "`` ", "``<Left>", { desc = "Insert `` pair" })

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
