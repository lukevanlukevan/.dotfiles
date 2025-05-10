return {
  "folke/which-key.nvim",
  opts = {
    -- Set helix preset layout
    preset = "helix",
    -- Register your key groups
    spec = {
      { "d", group = "delete", mode = { "n", "v" } },
      { "da", group = "around", mode = { "n", "v" } },
      { "dd", "dd", desc = "Delete line", mode = { "n", "v" } },
    },
    -- Customize the window appearance
    win = {
      border = "rounded",
      title = true,
      title_pos = "center",
    },
    -- Adjust layout properties
    layout = {
      spacing = 8, -- spacing between columns
      width = { min = 25 }, -- minimum width of columns
    },
    -- Scroll keybindings
    keys = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    -- Plugin behaviors
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
    -- Adjust the trigger timeout
    delay = 10,
  },
}
