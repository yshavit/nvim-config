-- Format text inline
vim.api.nvim_create_user_command("FormatJson", function(opts)
  local cmd = string.format("%d,%d!jq .", opts.line1, opts.line2)
  vim.cmd(cmd)
end, { range = true, desc = "Format JSON in range" })

-- Scratch buffers
_G.scratch_counter = _G.scratch_counter or 0
vim.api.nvim_create_user_command("Scratch", function(opts)
  vim.cmd("enew")
  _G.scratch_counter = _G.scratch_counter + 1
  local prefix = opts.args ~= "" and opts.args .. " " or ""
  local name = prefix .. "Scratch " .. _G.scratch_counter
  vim.api.nvim_buf_set_name(0, name)
  vim.cmd("setlocal buftype=nowrite")
  vim.cmd("setlocal bufhidden=hide")
  vim.cmd("setlocal noswapfile")
  vim.cmd("startinsert")
end, { nargs = "?", desc = "Create a new scratch buffer" })

vim.api.nvim_create_user_command("VScratch", function(opts)
  vim.cmd("vnew")
  _G.scratch_counter = _G.scratch_counter or 0
  _G.scratch_counter = _G.scratch_counter + 1
  local prefix = opts.args ~= "" and opts.args .. " " or ""
  local name = prefix .. "Scratch " .. _G.scratch_counter
  vim.api.nvim_buf_set_name(0, name)
  vim.cmd("setlocal buftype=nowrite")
  vim.cmd("setlocal bufhidden=hide")
  vim.cmd("setlocal noswapfile")
  vim.cmd("startinsert")
end, { nargs = "?", desc = "Create a new scratch buffer in vertical split" })

-- Memdiff
vim.api.nvim_create_user_command("Memdiff", function()
  vim.cmd("Scratch Diff")
  vim.cmd("diffthis")
  vim.cmd("VScratch Diff")
  vim.cmd("diffthis")
  vim.cmd("wincmd h") -- Move cursor to left window
end, { desc = "Diff current buffer against a new scratch buffer" })

-- BetterTerm layout commands. See lua/plugins/betterterm.lua for the complete reference.
-- These preserve terminal buffers and their running jobs;
-- only the terminal window is recreated with the selected layout.
local function set_betterterm_layout(layout)
  local betterterm = require("betterTerm")
  betterterm.setup(layout)

  if vim.bo.filetype == "better_term" then
    local name = vim.fn.bufname()
    betterterm.open(name) -- hide the active terminal window
    betterterm.open(name) -- recreate it with the new layout
  else
    betterterm.open()
  end
end

local function split_layout(position, size)
  return function()
    set_betterterm_layout({ display = "split", position = position, size = size() })
  end
end

-- BetterTerm inserts `position` directly before `:sbuffer`; use complete Ex
-- modifiers rather than its documented left/right shorthands (e.g. `right sb`)
-- which Neovim parses as the unrelated `:right` command.
local function horizontal_size()
  return math.floor(vim.o.lines / 2)
end
local function vertical_size()
  return math.floor(vim.o.columns * 0.4)
end
vim.api.nvim_create_user_command(
  "TermLeft",
  split_layout("topleft vertical", vertical_size),
  { desc = "Move BetterTerm left", force = true }
)
vim.api.nvim_create_user_command(
  "TermBottom",
  split_layout("botright", horizontal_size),
  { desc = "Move BetterTerm to the bottom", force = true }
)
vim.api.nvim_create_user_command(
  "TermTop",
  split_layout("topleft", horizontal_size),
  { desc = "Move BetterTerm to the top", force = true }
)
vim.api.nvim_create_user_command(
  "TermRight",
  split_layout("botright vertical", vertical_size),
  { desc = "Move BetterTerm right", force = true }
)
vim.api.nvim_create_user_command("TermFloat", function()
  set_betterterm_layout({ display = "float" })
end, { desc = "Float BetterTerm", force = true })
