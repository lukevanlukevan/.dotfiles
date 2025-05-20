require("render-markdown").setup({
  checkbox = {
    enabled = true,
    render_modes = false,
    right_pad = 1,
    unchecked = {
      icon = "󰄱 ",
      highlight = "RenderMarkdownUnchecked",
      scope_highlight = nil,
    },
    checked = {
      icon = "󰱒 ",
      highlight = "RenderMarkdownChecked",
      scope_highlight = nil,
    },
    custom = {
      todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
    },
  },
})
-- return {
--   "MeanderingProgrammer/render-markdown.nvim",
--   opts = {
--     -- code = {
--     --   sign = false,
--     --   width = "block",
--     --   right_pad = 1,
--     -- },
--     -- heading = {
--     --   sign = true,
--     --   icons = {},
--     -- },
--     -- checkbox = {
--     --   enabled = false,
--     -- },
--   },
--   -- ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
--   -- config = function(_, opts)
--   --   require("render-markdown").setup(opts)
--   --   Snacks.toggle({
--   --     name = "Render Markdown",
--   --     get = function()
--   --       return require("render-markdown.state").enabled
--   --     end,
--   --     set = function(enabled)
--   --       local m = require("render-markdown")
--   --       if enabled then
--   --         m.enable()
--   --       else
--   --         m.disable()
--   --       end
--   --     end,
--   --   }):map("<leader>um")
--   -- end,
-- }
