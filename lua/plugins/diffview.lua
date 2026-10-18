-- Git diff viewer.
--
-- Pinned to a specific commit: upstream has been unmaintained since Aug 2024
-- (last commit Jun 2024, 130+ open issues) but the repo is not archived, so the
-- account is still a live path into this config. Pinning means a compromised
-- upstream can't arrive via `:Lazy sync`. There's nothing to gain from tracking
-- `main` -- it hasn't moved in two years.
--
-- Security note: path arguments to `:DiffviewOpen` / `-C=` / `--selected-file=`
-- are run through `vim.fn.expand()`, which performs backtick command
-- substitution. Repo contents, commit messages and branch names are NOT
-- affected, but don't build these arguments from `<cfile>`, file contents, or
-- picker output -- and beware tab-completing a filename containing backticks.
return {
  "sindrets/diffview.nvim",
  commit = "4516612fe98ff56ae0415a259ff6361a89419b0a", -- 2024-06-13, current HEAD of main
  opts = {},
}
