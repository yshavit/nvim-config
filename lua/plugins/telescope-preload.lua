return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    config = function()
      vim.schedule(function()
        pcall(require, "telescope")
        pcall(function()
          require("telescope").load_extension("fzf")
        end)
      end)
    end,
  },
}
