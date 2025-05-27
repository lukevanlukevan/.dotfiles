local ltrim = function(s)
  return s:match("^%s*(.*)")
end

local get_todo_state = function()
  local current_line = vim.api.nvim_get_current_line()
  local starter = ltrim(current_line):sub(1, 5)
  local outer = ltrim(current_line):sub(6)
  local filler = "none"
  if starter == "- [ ]" then
    filler = "x"
  elseif starter == "- [x]" then
    filler = " "
  end
  return filler, outer
end

local toggle_todo = function()
  local filler, outer = get_todo_state()
  if filler ~= "none" then
    vim.api.nvim_set_current_line("- [" .. filler .. "]" .. outer)
  end
end

vim.keymap.set("n", "<M-x>", function()
  toggle_todo()
end, { silent = true })
