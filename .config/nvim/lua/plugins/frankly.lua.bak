local non_win = vim.fn.has("macunix")
if non_win == 1 then
  PLUGIN_DIR = "~/Code/frankly.nvim"
  TODO_DIR = "~/todo"
else
  PLUGIN_DIR = "D:/Code/frankly.nvim"
  TODO_DIR = "C:/Users/PIC-TWO/Documents/todo"
end
return {
  "frankly.nvim", -- Assuming this is the name of your plugin
  -- lazy = true,
  dir = PLUGIN_DIR, -- dir = "D:/Code/frankly.nvim",
  opts = {
    target_dir = "$TODOS",
    border = "single", -- single, rounded, etc.
    width = 85, -- width in columns
    height = 45, -- height in lines
  },
}
