return {
  "L3MON4D3/LuaSnip",
  version = "v2.3", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  build = "make install_jsregexp",
  config = function()
    -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.resolve(vim.fn.stdpath("config") .. "/snippets") })
    require("luasnip").config.setup({
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })
  end,
}
