local Job = require("plenary.job")

-- TTLs in seconds
local LOCAL_TTL = 20
local FETCH_TTL = 600

-- cache table
local git_status_cache = {
  text = "",
  last_local = 0,
  last_fetch = 0,
  fetch_error = false,
}

local config_dir = vim.fn.stdpath("config")
local header = " nvim config "

local function fetch_origin()
  Job:new({
    command = "git",
    args = { "-C", config_dir, "fetch" },
    on_exit = function(_, return_val)
      git_status_cache.fetch_error = return_val ~= 0
      git_status_cache.last_fetch = vim.uv.hrtime() / 1e9
    end,
  }):start()
end

-- Parse git status v2 output to extract branch info and changes
local function parse_git_status_v2(output)
  local has_uncommitted = false
  local ahead = 0
  local behind = 0

  for _, line in ipairs(output) do
    -- Branch header line: # branch.ab +<ahead> -<behind>
    if line:match("^# branch%.ab") then
      local ahead_str, behind_str = line:match("%+(%d+)%s+%-(%d+)")
      ahead = tonumber(ahead_str) or 0
      behind = tonumber(behind_str) or 0
    -- Any change line (1, 2, u, or ?) indicates uncommitted changes
    elseif line:match("^[12u%?]") then
      has_uncommitted = true
    end
  end

  return has_uncommitted, ahead, behind
end

-- async check git status (single call)
local function update_local_status()
  Job:new({
    command = "git",
    args = { "-C", config_dir, "status", "--porcelain=v2", "--branch" },
    on_exit = function(j)
      local output = j:result()
      local has_uncommitted, ahead, behind = parse_git_status_v2(output)

      local msg = ""
      if has_uncommitted then
        msg = msg .. "~"
      end
      if ahead > 0 then
        msg = msg .. "↑"
      end
      if behind > 0 then
        msg = msg .. "↓"
      end
      if git_status_cache.fetch_error then
        msg = msg .. "!"
      end

      git_status_cache.text = (msg ~= "" and header .. msg) or ""
      git_status_cache.last_local = vim.uv.hrtime() / 1e9
    end,
  }):start()
end

-- function used in lualine
local function git_status_component()
  local now = vim.uv.hrtime() / 1e9

  if now - git_status_cache.last_fetch > FETCH_TTL then
    fetch_origin()
  end

  if now - git_status_cache.last_local > LOCAL_TTL then
    update_local_status()
  end

  return git_status_cache.text
end

vim.api.nvim_create_user_command("NvimConfigRefresh", function()
  update_local_status()
end, {})

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_x[#opts.sections.lualine_x + 1] = { git_status_component, color = { fg = "#ff9e64" } }
    end,
  },
}
