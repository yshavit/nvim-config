-- in your lualine override/plugin
local function config_git_status()
  local config_dir = vim.fn.stdpath("config")
  local header = " nvim config "

  -- Fetch from origin and check for errors
  local handle = io.popen("cd " .. config_dir .. " && git fetch 2>&1; echo $?")
  if not handle then
    return header .. "!"
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
    return header .. "!"
  end

  -- check uncommitted changes
  handle = io.popen("cd " .. config_dir .. " && git status --porcelain 2>/dev/null")
  local uncommitted = handle and handle:read("*a") or ""
  if handle then
    handle:close()
  end

  -- check unpushed commits
  handle = io.popen("cd " .. config_dir .. " && git log @{u}.. --oneline 2>/dev/null")
  local unpushed = handle and handle:read("*a") or ""
  if handle then
    handle:close()
  end

  -- check commits to pull
  handle = io.popen("cd " .. config_dir .. " && git log ..@{u} --oneline 2>/dev/null")
  local to_pull = handle and handle:read("*a") or ""
  if handle then
    handle:close()
  end

  local msg = ""
  if uncommitted ~= "" then
    msg = msg .. "~"
  end
  if unpushed ~= "" then
    msg = msg .. "↑"
  end
  if to_pull ~= "" then
    msg = msg .. "↓"
  end

  if msg ~= "" then
    return header .. msg -- icon + text
  end
  return "" -- nothing if all clean
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_x[#opts.sections.lualine_x + 1] = { config_git_status, color = { fg = "#ff9e64" } }
      opts.sections.lualine_z = {} -- no clock
    end,
  },
}
