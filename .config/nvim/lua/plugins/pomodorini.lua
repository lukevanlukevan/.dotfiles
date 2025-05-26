return {
  "lukevanlukevan/pomodorini.nvim",
  dependencies = {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>t", icon = "🍅", group = "Pomodorini" },
      },
    },
  },
  opts = {
    status_line = { "[r]estart [b]reak [c]lose" },
    use_highlight = false,
    highlight_color = "00FF00",
    timer_dur = 25,
    break_dur = 5,
    use_snacks = false,
    keymaps = {
      start = "<leader>tq",
      show = "<leader>ts",
      hide = "<leader>th",
      pause_toggle = "<leader>tp",
    },
  },
}

-- return {
--   {
--     dir = "~/.dotfiles/pomodorini.nvim",
--     opts = {
--       status_line = { "[r]estart [b]reak [c]lose" },
--       use_highlight = false,
--       highlight_color = "00FF00",
--       timer_dur = 12,
--       break_dur = 5,
--       use_snacks = true,
--       keymaps = {
--         start = "<leader>tq",
--         show = "<leader>ts",
--         hide = "<leader>th",
--         pause_toggle = "<leader>tp",
--       },
--     },
--   },
-- }
