-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set

-- BetterTerm mappings. See lua/plugins/betterterm.lua for the complete reference.
-- These must be defined after LazyVim's defaults, so they replace the Snacks terminal
-- mapping. Some terminals send Ctrl+/ as Ctrl+_, so map both representations.
local function toggle_betterterm()
  require("betterTerm").open()
end

map({ "n", "t" }, "<C-/>", toggle_betterterm, { desc = "Toggle BetterTerm" })
map({ "n", "t" }, "<C-_>", toggle_betterterm, { desc = "Toggle BetterTerm" })
-- Double Ctrl+\ enters Terminal-normal mode without consuming ordinary text.
map("t", "<C-\\><C-\\>", "<C-\\><C-n>", { desc = "Terminal normal mode" })

-- Use leader mappings for terminal navigation so Windows Terminal and Ghostty
-- do not intercept the shortcuts before Neovim receives them.
local function betterterm_buffers()
  local terminals = {}
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].filetype == "better_term" then
      terminals[#terminals + 1] = {
        buffer = buffer,
        name = vim.api.nvim_buf_get_name(buffer),
      }
    end
  end
  return terminals
end

local function cycle_betterterm(direction)
  return function()
    -- betterTerm.cycle() calls open(), which hides the active terminal when
    -- there is only one. Navigation should be a no-op in that situation.
    if #betterterm_buffers() < 2 then
      return
    end
    require("betterTerm").cycle(direction)
  end
end

local function focus_betterterm(index)
  local current_buffer = vim.api.nvim_get_current_buf()
  for _, terminal in ipairs(betterterm_buffers()) do
    -- Configured betterTerm buffer names (including renamed ones) end in " index".
    if vim.endswith(terminal.name, " " .. index) then
      if terminal.buffer ~= current_buffer then
        require("betterTerm").switch_to(terminal.name)
      end
      return
    end
  end
  -- Let betterTerm create an index that does not yet exist.
  require("betterTerm").open(index)
end

local function select_betterterm()
  local terminals = betterterm_buffers()
  vim.ui.select(terminals, {
    prompt = "Select BetterTerm",
    format_item = function(terminal)
      return terminal.name
    end,
  }, function(terminal)
    if terminal and terminal.buffer ~= vim.api.nvim_get_current_buf() then
      require("betterTerm").switch_to(terminal.name)
    end
  end)
end

map("n", "<leader>tn", cycle_betterterm(1), { desc = "Next BetterTerm" })
map("n", "<leader>tp", cycle_betterterm(-1), { desc = "Previous BetterTerm" })
map("n", "<leader>tt", select_betterterm, { desc = "Select BetterTerm" })
map("n", "<leader>tr", function()
  require("betterTerm").rename()
end, { desc = "Rename BetterTerm" })
map("n", "<leader>tq", function()
  if vim.bo.filetype == "better_term" then
    require("betterTerm").close(vim.fn.bufname())
  end
end, { desc = "Close BetterTerm" })

for index = 0, 9 do
  local terminal = index
  map("n", "<leader>t" .. terminal, function()
    focus_betterterm(terminal)
  end, { desc = "Focus BetterTerm " .. terminal })
end

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
