-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add,./spell/local.utf-8.add"
vim.o.showcmd = false

vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 1 then
  -- Don't use unnamedplus. Instead, use native nvim buffers, and then sync
  -- to and from the windows clipboard on nvim [un]focus.
  vim.opt.clipboard = ""

  vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    callback = function()
      local sys = vim.fn.getreg("+")
      if sys ~= "" then
        vim.fn.setreg('"', sys)
      end
    end,
  })

  local did_yank = false

  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      did_yank = true
    end,
  })

  vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
      if did_yank then
        vim.fn.setreg("+", vim.fn.getreg('"'))
        did_yank = false
      end
    end,
  })
end
