local bufnr = vim.api.nvim_get_current_buf()

foo = "bar"

local ns_id = vim.api.nvim_create_namespace("pomodorini")
-- vim.cmd("highlight timerBar ctermfg=foo guibg=#FF0000")
-- vim.api.nvim_buf_set_extmark(
-- bufnr, -- 0 refers to the current buffer
-- ns_id,
-- 1, -- Line 1 (0-indexed)
-- 0, -- Column 0 (0-indexed)
-- {
-- end_row = 1, -- Same line as start_line
-- end_col = 6, -- Highlights characters at index 0, 1, 2, 3, 4, 5 (exclusive end)
-- hl_group = "timerBar", -- Or any other highlight group like "Visual", "Search", "Todo"
-- }
-- )
