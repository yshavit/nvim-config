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
  config = function(_, opts)
    require("trouble").setup(opts)

    -- Auto-close Trouble symbols when focus is lost
    vim.api.nvim_create_autocmd("BufLeave", {
      pattern = "*",
      callback = function()
        local trouble = require("trouble")
        -- Check if we're leaving a Trouble buffer
        if vim.bo.filetype == "trouble" then
          -- Close the symbols mode specifically
          trouble.close("symbols")
        end
      end,
    })
  end,
}
