-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Platform-specific shell configuration
if vim.fn.has("win32") == 1 then
  vim.o.shell = "powershell"
  vim.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
else
  vim.o.shell = vim.fn.executable("zsh") == 1 and "/bin/zsh" or "/bin/bash"
  vim.o.shellcmdflag = "-c"
end

-- Shared settings
vim.opt.wrap = true
vim.opt.autoindent = true

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-- Enable LSP servers (configured in lua/plugins/lsp/init.lua)
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("pyright")
vim.lsp.enable("gdscript")

require("config.markdownhelpers")
