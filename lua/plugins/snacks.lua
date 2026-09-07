return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          -- Define custom action
          actions = {
            explorer_yank_relative = function(picker)
              local files = {}
              if vim.fn.mode():find("^[vV]") then
                picker.list:select()
              end
              -- Get git root, or fall back to explorer cwd if not in a git repo
              local root = Snacks.git.get_root(picker:cwd()) or picker:cwd()
              for _, item in ipairs(picker:selected({ fallback = true })) do
                local abs_path = Snacks.picker.util.path(item)
                -- Calculate relative path by stripping the root prefix, or use absolute if nil
                local relative_path = abs_path and abs_path:sub(#root + 2) or abs_path
                table.insert(files, relative_path)
              end
              picker.list:set_selected() -- clear selection
              local value = table.concat(files, "\n")
              vim.fn.setreg(vim.v.register or "+", value, "l")
              Snacks.notify.info("Yanked " .. #files .. " relative path" .. (#files > 1 and "s" or ""))
            end,
          },
          -- Add key mapping that references the action
          win = {
            list = {
              keys = {
                ["y"] = { "explorer_yank_relative", mode = { "n", "x" }, desc = "Yank relative path(s)" },
                ["Y"] = { "explorer_yank", mode = { "n", "x" }, desc = "Yank absolute path(s)" },
              },
            },
          },
        },
      },
    },
  },
}
