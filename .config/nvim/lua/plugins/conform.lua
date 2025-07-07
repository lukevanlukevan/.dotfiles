return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      gdscript = { "gdformat" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      jsx = { "prettier" },
      tsx = { "prettier" },
    },
    formatters = {
      gdformat = {
        command = "gdformat",
        stdin = false, -- must be false, or unset (default)
      },
    },
  },
}
