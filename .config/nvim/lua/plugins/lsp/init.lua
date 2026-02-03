return {
  -- Override lspconfig to fix mason-lspconfig API incompatibility
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      servers = {
        -- Godot
        gdscript = {
          mason = false,
          cmd = { "ncat", "127.0.0.1", "6005" },
          filetypes = { "gd", "gdscript" },
          root_dir = require("lspconfig.util").root_pattern("project.godot", ".git"),
        },
        -- Lua with Love2D support
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                telemetry = { enable = false },
                library = {
                  [vim.fn.expand("${3rd}/love2d/library")] = true,
                },
              },
              diagnostics = {
                globals = { "love" },
              },
            },
          },
        },
        -- Pyright for Windows/Houdini
        pyright = vim.fn.has("win32") == 1 and {
          settings = {
            python = {
              pythonPath = "C:/Program Files/Side Effects Software/Houdini 20.5.332/python311/python.exe",
              analysis = {
                extraPaths = {
                  "C:\\Program Files\\Side Effects Software\\Houdini 20.5.332\\houdini\\python3.11libs",
                },
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        } or {},
      },
    },
    config = function(_, opts)
      -- Setup formatter
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- Setup keymaps for servers
      for server, server_opts in pairs(opts.servers) do
        if type(server_opts) == "table" and server_opts.keys then
          require("lazyvim.plugins.lsp.keymaps").set({ name = server ~= "*" and server or nil }, server_opts.keys)
        end
      end

      -- Inlay hints
      if opts.inlay_hints and opts.inlay_hints.enabled then
        Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
            local exclude = opts.inlay_hints.exclude or {}
            if not vim.tbl_contains(exclude, vim.bo[buffer].filetype) then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end
        end)
      end

      -- Code lens
      if opts.codelens and opts.codelens.enabled and vim.lsp.codelens then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end

      -- Diagnostics
      local diagnostics = opts.diagnostics or {}
      if type(diagnostics.virtual_text) == "table" and diagnostics.virtual_text.prefix == "icons" then
        diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = LazyVim.config.icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      end
      vim.diagnostic.config(vim.deepcopy(diagnostics))

      -- Get capabilities
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_blink and blink.get_lsp_capabilities() or {},
        (opts.servers["*"] or {}).capabilities or {}
      )

      -- Get mason-lspconfig servers (using correct API)
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local mason_servers = {}
      if have_mason then
        -- Use the correct module path for mason-lspconfig
        local ok, mappings = pcall(require, "mason-lspconfig.mappings.server")
        if ok then
          mason_servers = vim.tbl_keys(mappings.lspconfig_to_package or {})
        end
      end

      -- Setup function for each server
      local function setup(server)
        local server_opts = opts.servers[server]
        if not server_opts or server_opts == false then
          return
        end
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled == false then
          return
        end

        local final_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, server_opts)

        -- Remove non-lspconfig keys
        final_opts.mason = nil
        final_opts.enabled = nil
        final_opts.keys = nil

        require("lspconfig")[server].setup(final_opts)
      end

      -- Setup servers
      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if server ~= "*" and server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            if server_opts.mason == false or not vim.tbl_contains(mason_servers, server) then
              setup(server)
            else
              table.insert(ensure_installed, server)
            end
          end
        end
      end

      -- Setup mason-lspconfig
      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup },
        })
      end
    end,
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed or {}) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
