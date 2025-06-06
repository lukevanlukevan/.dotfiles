local non_win = vim.fn.has("macunix")
if non_win then
  PLUGIN_DIR = "D:/Code/frankly.nvim"
  TODO_DIR = "C:/Users/PIC-TWO/Documents/todo"
else
  PLUGIN_DIR = "~/Code/frankly.nvim"
  TODO_DIR = "~/todo"
end
return {
  "frankly.nvim", -- Assuming this is the name of your plugin
  dir = PLUGIN_DIR, -- dir = "D:/Code/frankly.nvim",
  opts = {
    target_dir = TODO_DIR,
    border = "rounded", -- single, rounded, etc.
    width = 85, -- width in columns
    height = 45, -- height in lines
  },
}
