-- MyST / Markdown support
return {
  {
    "plasticboy/vim-markdown",
    ft = { "markdown", "rmd" },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_math = 1        -- enable $...$ math highlighting
      vim.g.vim_markdown_conceal = 0     -- show raw MyST directives
    end
  },
}

