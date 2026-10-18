return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      -- RustLsp's picker handles rust-analyzer's grouped actions. Enable its
      -- vim.ui.select fallback too, so ordinary actions such as Clippy fixes
      -- are available from the same mapping.
      opts.tools = opts.tools or {}
      opts.tools.code_actions = opts.tools.code_actions or {}
      opts.tools.code_actions.ui_select_fallback = true

      opts.server = opts.server or {}
      local on_attach = opts.server.on_attach
      opts.server.on_attach = function(client, bufnr)
        if on_attach then
          on_attach(client, bufnr)
        end

        -- LazyVim installs its generic LSP mappings on LspAttach, after this
        -- callback. Schedule the Rust-specific mapping so it takes precedence.
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end

          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { buffer = bufnr, desc = "Code Action" })
          vim.keymap.set("x", "<leader>ca", ":RustLsp codeAction<CR>", {
            buffer = bufnr,
            desc = "Code Action",
          })
        end)
      end

      return opts
    end,
  },
}
