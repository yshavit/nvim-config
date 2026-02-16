return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      symbols = {
        -- Auto-focus to the symbols pane
        focus = true,
        -- Don't automatically jump in the main doc
        auto_jump = false,
        win = {
          -- floating at the top, Quake-style
          relative = "editor",
          type = "float",
          border = "rounded",
          position = { 0, 0.5 },
          size = {
            width = 0.8,
            height = 0.5,
          },
        },
        preview = {
          -- at the bottom, with a rounded border
          type = "float",
          relative = "editor",
          border = "rounded",
          position = { 1, 0.5 },
          size = {
            width = 1,
            height = 0.3,
          },
        },
      },
    },
  },
}
