return {
  {
    "laytan/tailwind-sorter.nvim",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    build = "cd formatter && npm ci && npm run build",
    config = true,
    opts = {
      on_save_enabled = true,
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      server = {
        override = false,
      },
    },
    config = function(_, opts)
      require("tailwind-tools").setup(opts)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("TailwindSortPreSave", { clear = true }),
        pattern = { "*.jsx", "*.tsx", "*.html" },
        callback = function()
          vim.cmd("TailwindSort")
        end,
      })
    end,
  },
}
