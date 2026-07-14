-- Conditionally disable nvim-treesitter in environments where tree-sitter binary
-- is incompatible (e.g., devcontainer with older glibc than tree-sitter requires).
-- Set NVIM_DISABLE_TREESITTER=1 in the environment to disable the plugin.
if not vim.env.NVIM_DISABLE_TREESITTER then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
  },
}
