return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local function check_config_git_status()
        local config_dir = vim.fn.stdpath("config") -- ~/.config/nvim

        -- Fetch from origin and check for errors
        local handle = io.popen("cd " .. config_dir .. " && git fetch 2>&1; echo $?")
        if not handle then
          return
        end
        local output = handle:read("*a")
        handle:close()

        -- Check if fetch failed (exit code will be on last line)
        local exit_code = output:match("(%d+)%s*$")
        if exit_code and tonumber(exit_code) ~= 0 then
          vim.notify(
            "Failed to fetch from origin. You may need to enter your SSH passphrase.\n\nConfig dir: ~/.config/nvim",
            vim.log.levels.ERROR,
            { title = "Neovim Config Git Fetch Failed" }
          )
          return
        end

        -- Check for uncommitted changes
        local handle = io.popen("cd " .. config_dir .. " && git status --porcelain 2>/dev/null")
        if not handle then
          return
        end
        local uncommitted = handle:read("*a")
        handle:close()

        -- Check for unpushed commits
        handle = io.popen("cd " .. config_dir .. " && git log @{u}.. --oneline 2>/dev/null")
        if not handle then
          return
        end
        local unpushed = handle:read("*a")
        handle:close()

        -- Check for commits to pull
        handle = io.popen("cd " .. config_dir .. " && git log ..@{u} --oneline 2>/dev/null")
        if not handle then
          return
        end
        local to_pull = handle:read("*a")
        handle:close()

        -- Build message
        local messages = {}
        if uncommitted and uncommitted ~= "" then
          table.insert(messages, "• Uncommitted changes")
        end
        if unpushed and unpushed ~= "" then
          table.insert(messages, "• Unpushed commits")
        end
        if to_pull and to_pull ~= "" then
          table.insert(messages, "• Commits to pull from origin")
        end

        if #messages > 0 then
          vim.notify(
            table.concat(messages, "\n") .. "\n\nConfig dir: ~/.config/nvim",
            vim.log.levels.WARN,
            { title = "Neovim Config Git Status" }
          )
        end
      end

      -- Run check after startup
      vim.defer_fn(check_config_git_status, 1000)

      return opts
    end,
  },
}
