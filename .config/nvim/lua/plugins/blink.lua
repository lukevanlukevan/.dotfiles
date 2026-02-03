return {
  "saghen/blink.cmp",
  -- enabled = false,
  -- version = "1.*",
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  opts = {

    keymap = {
      preset = "super-tab",
    },
    -- https://cmp.saghen.dev/configuration/keymap
    completion = {
      menu = {
        border = "rounded",
      },
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
    -- normal
    -- completion = {
    --   list = {
    --     selection = { preselect = false, auto_insert = false },
    --   },
    -- },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
