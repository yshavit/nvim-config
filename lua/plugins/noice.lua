local hint_g = {
  " :g/pat/d        delete matching lines",
  " :g/pat/s/a/b/g  substitute only on matches",
  ' :g/pat/norm Ax  append "x" to matching lines',
  " :g/pat/yank A   yank matches → register a",
  " :g/pat/p        print all matching lines (doesn't modify buffer)",
  " :g/pat/#        print all matching lines w/ line numbers",
  " :g/pat/m$       move matches to end",
  " :g/pat/t0       copy matches to top",
}

local hint_v = {
  " :v/pat/d        keep only matching lines",
  " :v/pat/s/a/b/g  substitute on non-matches",
  " :v/pat/norm >>  indent non-matching lines",
}

local win_id = nil

local function close_hint()
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, true)
  end
  win_id = nil
end

local function show_hint(lines, hl)
  close_hint()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, #line)
  end

  win_id = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    row = vim.o.lines - #lines - 4,
    col = math.floor((vim.o.columns - width - 2) / 2),
    width = width + 2,
    height = #lines,
    style = "minimal",
    border = "rounded",
    title = hl == "DiagnosticInfo" and " global " or " vglobal ",
    title_pos = "center",
  })

  vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:" .. hl, { win = win_id })
end

local function on_cmdline_changed()
  local cmd = vim.fn.getcmdline()
  local type = vim.fn.getcmdtype()
  if type ~= ":" then
    return close_hint()
  end

  if cmd:match("^%%?g") or cmd:match("^'<,'>g") then
    show_hint(hint_g, "DiagnosticInfo")
  elseif cmd:match("^%%?v") or cmd:match("^'<,'>v") then
    show_hint(hint_v, "DiagnosticWarn")
  else
    close_hint()
  end
end

return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      format = {
        global_pct = {
          pattern = "^:%%g",
          icon = ":%g",
          icon_hl = "NoiceCmdlineIconCmdline",
          lang = "vim",
          title = " global grep (matching lines) ",
        },
        vglobal_pct = {
          pattern = "^:%%v",
          icon = ":%v",
          icon_hl = "NoiceCmdlineIconCmdline",
          lang = "vim",
          title = " global anti-grep (non-matching lines) ",
        },
        global_bare = {
          pattern = "^:g/",
          icon = ":g/",
          icon_hl = "NoiceCmdlineIconCmdline",
          lang = "vim",
          title = " global grep (matching lines) ",
        },
        vglobal_bare = {
          pattern = "^:v/",
          icon = ":v/",
          icon_hl = "NoiceCmdlineIconCmdline",
          lang = "vim",
          title = " global anti-grep (non-matching lines) ",
        },
        global_vis = {
          pattern = "^:'<,'>g",
          icon = ":'<,'>g",
          icon_hl = "NoiceCmdlineIconCmdline",
          lang = "vim",
          title = " visual selection grep (matching lines) ",
        },
        vglobal_vis = {
          pattern = "^:'<,'>v",
          icon = ":'<,'>v",
          icon_hl = "NoiceCmdlineIconCmdline",
          lang = "vim",
          title = " visual selection anti-grep (non-matching lines) ",
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("CmdlineChanged", { callback = on_cmdline_changed })
    vim.api.nvim_create_autocmd("CmdlineLeave", { callback = close_hint })
  end,
}
