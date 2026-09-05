return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.image = vim.tbl_deep_extend("force", opts.image or {}, { enabled = true })

    -- Snacks accepts ioctl results with zero pixel dimensions, which makes
    -- image fitting divide by zero. Retain its default 9x18 cell estimate
    -- when pixel dimensions are unavailable.
    local terminal = require("snacks.image.terminal")
    local size = terminal.size
    terminal.size = function()
      local dim = size()
      if dim.cell_width > 0 and dim.cell_height > 0 then
        return dim
      end
      return vim.tbl_extend("force", dim, {
        width = dim.columns * 9,
        height = dim.rows * 18,
        cell_width = 9,
        cell_height = 18,
        scale = 1,
      })
    end
  end,
}
