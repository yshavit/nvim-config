-- Only format changed hunks. Ignore hunk formatting in markdown, because othewise indentation gets mixed
return {
  {
    "LazyVim/LazyVim",
    opts = {
      autoformat = false,
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = false,
    },
    init = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatHunksOnSave", { clear = true }),
        callback = function(args)
          local bufnr = args.buf

          if vim.bo[bufnr].filetype == "markdown" then
            return
          end

          local ok, diff = pcall(require, "mini.diff")
          if not ok then
            return
          end

          local buf_data = diff.get_buf_data(bufnr)
          if not buf_data then
            return
          end

          local hunks = buf_data.hunks
          if not hunks or #hunks == 0 then
            return
          end

          local conform = require("conform")

          for i = #hunks, 1, -1 do
            local hunk = hunks[i]
            if hunk.buf_count > 0 then
              local start_line = hunk.buf_start
              local end_line = start_line + hunk.buf_count - 1
              conform.format({
                bufnr = bufnr,
                range = {
                  start = { start_line, 0 },
                  ["end"] = { end_line, math.huge },
                },
                async = false,
                timeout_ms = 3000,
                lsp_format = "fallback",
              })
            end
          end
        end,
      })

      vim.keymap.set("n", "<leader>cF", function()
        require("conform").format({ timeout_ms = 3000, lsp_format = "fallback" })
      end, { desc = "Format entire file" })
    end,
  },
}
