-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make the separator split easier to see
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[ highlight WinSeparator guifg=#ffffff guibg=#1e1e2e ]])
  end,
})
-- We have to separately do this when vim starts, for some reason
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd([[ highlight WinSeparator guifg=#ffffff guibg=#1e1e2e ]])
  end,
})
