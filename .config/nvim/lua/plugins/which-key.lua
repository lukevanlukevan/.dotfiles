return {
  "folke/which-key.nvim",
  opts = {
    preset = "helix",
    win = {
      border = "rounded",
      title = true,
      title_pos = "center",
    },
    layout = {
      spacing = 8,
      width = { min = 25 },
    },
    keys = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    plugins = {
      spelling = true,
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    delay = 10,
  },
}
