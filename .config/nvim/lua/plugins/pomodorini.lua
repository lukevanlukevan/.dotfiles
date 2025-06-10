local non_win = vim.fn.has("macunix")
if non_win == 1 then
  PLUGIN_DIR = "~/Code/pomodorini.nvim"
else
  PLUGIN_DIR = "D:/Code/pomodorini.nvim"
end
return {
  "lukevanlukevan/pomodorini.nvim",
  dir = PLUGIN_DIR,
  dependencies = {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>t", icon = "🍅", group = "Pomodorini" },
      },
    },
  },
  opts = {
    status_line = { "[r]estart [b]reak [q]uit", "Time to focus" },
    use_highlight = true,
    highlight_color = "FF0000",
    timer_dur = 25,
    break_dur = 5,
    use_snacks = true,
    align = "tr",
    v_margin = 1,
    h_margin = 1,
    keymaps = {
      start = "<leader>tt",
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
