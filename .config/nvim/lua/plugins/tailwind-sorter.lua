-- return {
--   "laytan/tailwind-sorter.nvim",
--   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
--   build = "cd formatter && npm ci && npm run build",
--   config = true,
--   opts = {
--     on_save_enabled = true,
--   },
-- }

-- tailwinds tools
return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
  },
  opts = {}, -- You can add your plugin-specific options here
  config = function(_, opts)
    require("tailwind-tools").setup(opts)

    -- Add your pre-save autocmd here
    local group = vim.api.nvim_create_augroup("TailwindSortPreSave", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = { "*.jsx", "*.tsx", "*.html" }, -- adjust as needed
      callback = function()
        vim.cmd("TailwindSort")
      end,
    })
  end,
}
