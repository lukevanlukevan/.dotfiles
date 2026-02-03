return {
  "saghen/blink.cmp",
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  opts = {
    keymap = {
      preset = "super-tab",
    },
    cmdline = {
      keymap = {
        preset = "super-tab",
        -- Override LazyVim's false values that break validation
        ["<Right>"] = {},
        ["<Left>"] = {},
      },
    },
    completion = {
      menu = {
        border = "rounded",
      },
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
