return {
  -- Override treesitter to use modern branch and add Tailwind-relevant parsers
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",  -- Switches to the rewritten, compatible version
    opts = function(_, opts)
      -- Merge with LazyVim defaults
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "html", "css", "javascript", "typescript", "tsx", "json",  -- For Tailwind/JSX/TSX
      })
      opts.highlight = { enable = true }
      opts.indent = { enable = true }
    end,
  },
  -- Disable textobjects (unneeded for your setup)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
  },
}
