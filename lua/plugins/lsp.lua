return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Helper function to find .gopls-local by walking up directory tree
      local function find_gopls_local(start_path)
        local current = start_path
        while current and current ~= "/" do
          local config_path = current .. "/.gopls-local"
          if vim.fn.filereadable(config_path) == 1 then
            return config_path
          end
          -- Move up one directory
          current = vim.fn.fnamemodify(current, ":h")
        end
        return nil
      end

      -- Read project-local gopls settings from .gopls-local if it exists
      local gopls_settings = {
        completeUnimported = true,
        experimentalWorkspaceModule = true,
        directoryFilters = {
          "-node_modules",
          "-vendor",
          "-bazel-out",
          "-**/testdata",
        },
      }

      local local_config_path = find_gopls_local(vim.fn.getcwd())
      if local_config_path then
        local content = vim.fn.readfile(local_config_path)
        for _, line in ipairs(content) do
          local key, value = line:match("^(%S+)%s*=%s*(.+)$")
          if key and value then
            -- Trim whitespace
            value = value:match("^%s*(.-)%s*$")
            gopls_settings[key] = value
          end
        end
      end

      opts.servers.gopls = {
        settings = {
          gopls = gopls_settings,
        },

        on_attach = function(client, bufnr)
          -- Disable all diagnostics for gopls (keep navigation/completion/etc)
          vim.diagnostic.enable(false, { bufnr = bufnr })

          -- Notify gopls of configuration (needed for settings like 'local' to take effect)
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })

          -- Organize imports with goimports on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              -- Get local package from .gopls-local
              local local_pkg = nil
              local buf_path = vim.api.nvim_buf_get_name(bufnr)
              local buf_dir = vim.fn.fnamemodify(buf_path, ":h")
              local local_config_path = find_gopls_local(buf_dir)

              if local_config_path then
                local content = vim.fn.readfile(local_config_path)
                for _, line in ipairs(content) do
                  local key, value = line:match("^(%S+)%s*=%s*(.+)$")
                  if key == "local" and value then
                    local_pkg = value:match("^%s*(.-)%s*$")
                    break
                  end
                end
              end

              -- Run goimports with --local flag if configured
              if local_pkg then
                local cmd = string.format("goimports -local %s -w %s", local_pkg, vim.fn.shellescape(buf_path))
                vim.fn.system(cmd)
                vim.cmd("edit!") -- Reload buffer
              else
                -- Fall back to gopls organize imports
                vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
              end
            end,
          })
        end,
      }
      return opts
    end,
  },
}
