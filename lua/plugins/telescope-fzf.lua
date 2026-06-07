local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

-- Check if gcc or cl exists
local function has_compiler()
  return vim.fn.executable("gcc") == 1 or vim.fn.executable("cl") == 1
end

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = (not is_windows) or has_compiler(),
    build = (not is_windows or has_compiler()) and "make" or nil,
  },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      if not is_windows or has_compiler() then
        require("telescope").load_extension("fzf")
      end
    end,
  },
}
