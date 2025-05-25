return {
  "saghen/blink.cmp",
  -- enabled = false,
  version = "1.*",
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
