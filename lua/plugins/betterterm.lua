-- BetterTerm reference
--
-- Toggle terminal 0:     <C-/> or <C-_>       (normal and terminal modes)
-- New terminal:          <C-t>                (terminal mode)
-- Terminal-normal mode:  <C-\><C-\>            (terminal mode)
-- Next / previous:       <leader>tn / <leader>tp
-- Select terminal:       <leader>tt
-- Rename terminal:       <leader>tr
-- Close terminal:        <leader>tq
-- Focus terminal 0-9:    <leader>t0 ... <leader>t9
-- Layout commands:       :TermLeft, :TermBottom, :TermTop, :TermRight, :TermFloat
--
-- See lua/config/keymaps.lua and lua/config/commands.lua for implementations.
return {
  "CRAG666/betterTerm.nvim",
  -- <C-/> is mapped in config/keymaps.lua so it overrides LazyVim's Snacks
  -- terminal mapping, which is registered after plugin specs are processed.
  opts = {
    prefix = "",
    bufname_format = function(prefix, index)
      return index .. "）" .. prefix
    end,
    new_tab_mapping = "<C-t>",
  },
}
