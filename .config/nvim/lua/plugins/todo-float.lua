return {
  "frankly.nvim", -- Assuming this is the name of your plugin
  dir = "~/Code/frankly.nvim",
  dependencies = {
    -- Correct way to configure nvim-treesitter as a dependency
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate", -- This command ensures parsers are installed
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "markdown", "markdown_inline", "lua" }, -- Crucial: ensures markdown parsers are installed
          highlight = {
            enable = true, -- Enables Tree-sitter based highlighting
          },
          indent = {
            enable = true, -- Enables Tree-sitter based indentation
          },
          -- You can add more configurations here for other languages or features
        })
      end,
    },
  },
  opts = {
    target_dir = "~/todo",
    border = "rounded", -- single, rounded, etc.
    width = 0.8, -- width of window in % of screen size
    height = 0.9, -- height of window in % of screen size
    position = "center", -- topleft, topright, bottomleft, bottomright
  },
}
