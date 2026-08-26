-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.spellfile = vim.fn.stdpath("config")
  .. "/spell/en.utf-8.local.add,"
  .. vim.fn.stdpath("config")
  .. "/spell/en.utf-8.add"
vim.o.showcmd = false

vim.opt.clipboard = "unnamedplus"
if vim.fn.has("win32") == 1 then
  -- Neovim auto-detects `win32yank.exe` on $PATH, but if it resolves to the
  -- chocolatey shim it pops up a console window on every yank/paste. Pin the
  -- provider to the win32yank that ships alongside nvim.exe.
  local win32yank = vim.fn.fnamemodify(vim.v.progpath, ":h") .. "\\win32yank.exe"
  if vim.fn.executable(win32yank) == 0 then
    -- Fall back to whatever is on $PATH if the bundled copy isn't there.
    win32yank = "win32yank.exe"
  end
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = { win32yank, "-i", "--crlf" },
      ["*"] = { win32yank, "-i", "--crlf" },
    },
    paste = {
      ["+"] = { win32yank, "-o", "--lf" },
      ["*"] = { win32yank, "-o", "--lf" },
    },
    cache_enabled = false,
  }
elseif vim.fn.has("wsl") == 1 then
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
