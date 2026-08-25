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
