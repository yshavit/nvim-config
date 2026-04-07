return {
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
