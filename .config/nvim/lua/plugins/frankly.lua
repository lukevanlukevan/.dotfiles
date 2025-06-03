return {
  "frankly.nvim", -- Assuming this is the name of your plugin
  -- dir = "~/Code/frankly.nvim",
  dir = "D:/Code/frankly.nvim",
  -- dependencies = {
  --   -- Correct way to configure nvim-treesitter as a dependency
  --   {
  --     "nvim-treesitter/nvim-treesitter",
  --     build = ":TSUpdate", -- This command ensures parsers are installed
  --     config = function()
  --       require("nvim-treesitter.configs").setup({
  --         ensure_installed = { "markdown", "markdown_inline", "lua" }, -- Crucial: ensures markdown parsers are installed
  --         highlight = {
  --           enable = true, -- Enables Tree-sitter based highlighting
  --         },
  --         indent = {
  --           enable = true, -- Enables Tree-sitter based indentation
  --         },
  --         -- You can add more configurations here for other languages or features
  --       })
  --     end,
  --   },
  -- },
  opts = {
    -- target_dir = "~/todo",
    target_dir = "C:/Users/PIC-TWO/Documents/todo",
    border = "rounded", -- single, rounded, etc.
    width = 85, -- width in columns
    height = 45, -- height in lines
  },
}
