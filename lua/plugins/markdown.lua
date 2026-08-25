return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          -- Note: markdown diagnostics are disabled by default. See autocmds.lua
          prepend_args = { "--config", vim.fn.expand("~/.config/nvim/markdownlint.json") },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      latex = {
        enabled = false,
      },
      heading = {
        enabled = true,
        icons = { "❱ ", "❯❯ ", "❯❯❯ ", "❯❯❯❯ ", "❯❯❯❯❯ ", "❯❯❯❯❯❯ " },
      },
      code = {
        width = "full",
        conceal_delimiters = false,
        langage_pad = 2,
        language_border = "█",
        language_left = "█",
        language_right = "██",
        border = "thin",
      },
      checkbox = {
        enabled = true,
        checked = {
          icon = "-  󰱒 ",
        },
        unchecked = {
          icon = "-  󰄱 ",
        },
      },
    },
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
