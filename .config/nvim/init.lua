-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Platform-specific shell configuration using vim.fn.has
if vim.fn.has("macunix") == 1 then
  vim.o.shell = "/bin/zsh" -- or /bin/bash or your preferred shell
  vim.o.shellcmdflag = "-c"
else
  vim.o.shell = "powershell"
  vim.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
end

-- Shared settings
vim.opt.wrap = true
vim.opt.autoindent = true

-- transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
-- end transparent background

vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("pyright")
vim.lsp.enable("prettier")
vim.lsp.enable("gdscript")

require("config.markdownhelpers")

-- THIS IS JUST GODOT STUFF
-- Start Neovim TCP server if inside a Godot project
-- local uv = vim.uv or vim.loop
-- local cwd = vim.fn.getcwd()
-- local project_root = nil
--
-- -- Find project.godot in current or parent directory
-- if uv.fs_stat(cwd .. "/project.godot") then
--   project_root = cwd
-- elseif uv.fs_stat(cwd .. "/../project.godot") then
--   project_root = cwd .. "/../"
-- end
--
-- -- Start TCP server
-- if project_root then
--   vim.fn.serverstart("127.0.0.1:6666")
--   print("Started Godot server on 127.0.0.1:6666")
-- end
-- END GODOT STUFF
