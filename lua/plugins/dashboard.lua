return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Ensure dashboard config exists
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.keys = opts.dashboard.preset.keys or {}

    -- Find the index of the item with key "n"
    local insert_index = nil
    for i, item in ipairs(opts.dashboard.preset.keys) do
      if item.key == "n" then
        insert_index = i + 1 -- Insert after "n"
        break
      end
    end
    -- If not found, prepend (insert at position 1)
    insert_index = insert_index or 1

    table.insert(opts.dashboard.preset.keys, insert_index, {
      icon = "󰙏",
      key = ".",
      desc = "New Scratchpad",
      action = ":Scratch",
    })

    return opts
  end,
}
