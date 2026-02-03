return {
  "S1M0N38/love2d.nvim",
  event = "VeryLazy",
  opts = function()
    -- Platform-specific love2d binary path
    local love_bin
    if vim.fn.has("mac") == 1 then
      love_bin = "/Applications/love.app/Contents/MacOS/love"
    elseif vim.fn.has("win32") == 1 then
      love_bin = "love"
    else
      love_bin = vim.fn.executable("love") == 1 and "love" or "/usr/bin/love"
    end

    return {
      path_to_love_bin = love_bin,
      path_to_love_library = vim.fn.globpath(vim.o.runtimepath, "love2d/library"),
      restart_on_save = false,
      debug_window_opts = nil,
    }
  end,
  keys = {
    { "<leader>v", ft = "lua", desc = "LÖVE" },
    { "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
    { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
  },
}
