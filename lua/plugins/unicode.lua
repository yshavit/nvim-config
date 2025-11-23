return {
  "chrisbra/unicode.vim",
  keys = {
    {
      "<leader>fu",
      function()
        -- Save the current buffer list before opening UnicodeTable
        local buffers_before = vim.api.nvim_list_bufs()

        -- First, run UnicodeTable to ensure plugin loads and creates its buffer
        vim.cmd("UnicodeTable")

        -- Get the current buffer (which should be the UnicodeTable buffer)
        local buf = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()

        -- Find any new buffers created by UnicodeTable
        local buffers_after = vim.api.nvim_list_bufs()
        local new_buffers = {}
        for _, b in ipairs(buffers_after) do
          local is_new = true
          for _, old_b in ipairs(buffers_before) do
            if b == old_b then
              is_new = false
              break
            end
          end
          if is_new then
            table.insert(new_buffers, b)
          end
        end

        -- Close the split window that was just created
        vim.api.nvim_win_close(win, false)

        -- Get editor dimensions
        local width = vim.o.columns
        local height = vim.o.lines

        -- Calculate floating window size (80% of screen)
        local win_width = math.floor(width * 0.8)
        local win_height = math.floor(height * 0.8)

        -- Calculate centered position
        local row = math.floor((height - win_height) / 2)
        local col = math.floor((width - win_width) / 2)

        -- Window options
        local opts = {
          relative = "editor",
          width = win_width,
          height = win_height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
        }

        -- Open the floating window with the existing buffer
        local float_win = vim.api.nvim_open_win(buf, true, opts)

        -- Set window options
        vim.wo[float_win].winblend = 0

        -- Map 'q' and ESC to close the window AND delete ALL related buffers
        local function close_and_delete()
          pcall(vim.api.nvim_win_close, float_win, true)
          vim.schedule(function()
            -- Delete all buffers that were created by UnicodeTable
            for _, b in ipairs(new_buffers) do
              if vim.api.nvim_buf_is_valid(b) then
                -- Safety checks before deleting
                local bufname = vim.api.nvim_buf_get_name(b)
                local is_modified = vim.bo[b].modified
                local is_unicode_table = bufname:match("UnicodeTable%.txt$") ~= nil

                -- Only delete if it's a UnicodeTable buffer and not modified
                if is_unicode_table and not is_modified then
                  pcall(vim.api.nvim_buf_delete, b, { force = true })
                end
              end
            end
          end)
        end

        vim.keymap.set("n", "q", close_and_delete, { buffer = buf, noremap = true, silent = true })
        vim.keymap.set("n", "<Esc>", close_and_delete, { buffer = buf, noremap = true, silent = true })
      end,
      desc = "Unicode Table (Float)",
    },
  },
}
