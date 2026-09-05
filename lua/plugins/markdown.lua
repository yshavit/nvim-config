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
    -- Won't be needed after https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/616 is implemented
    "ice345/markdown-table-wrap.nvim",
    -- Codex reviewed this commit for safety on 2026-09-04; review again before updating.
    commit = "281069c1107a510028fab5f5b0a74a226ed2036d",
    ft = { "markdown", "quarto", "rmd" },
    opts = {
      -- Keep normal reading/editing in Source; use wrapped tables only on demand.
      auto_preview = false,
      max_col_width = 120,
      max_width_ratio = 0.95,
      fit_to_window = true,
    },
    keys = {
      {
        "<leader>tf",
        "<cmd>MarkdownTableFloatPreview<cr>",
        desc = "Table Float",
        ft = { "markdown", "quarto", "rmd" },
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
