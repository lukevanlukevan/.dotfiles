local bufnr = vim.api.nvim_get_current_buf()

foo = "bar"

local ns_id = vim.api.nvim_create_namespace("pomodorini")
vim.cmd("highlight timerBar guibg=#FF0000")
local target_line_idx = 0 -- Line 1 (0-indexed)
local line_content = vim.api.nvim_buf_get_lines(bufnr, target_line_idx, target_line_idx + 1, true)[1]
local line_length = #line_content
local desired_end_col = 6
local safe_end_col = math.min(desired_end_col, line_length)
vim.api.nvim_buf_set_extmark(
	bufnr, -- 0 refers to the current buffer
	ns_id,
	target_line_idx, -- Line 1 (0-indexed)
	0, -- Column 0 (0-indexed)
	{
		end_row = target_line_idx, -- Same line as start_line
		end_col = safe_end_col, -- Highlights characters at index 0, 1, 2, 3, 4, 5 (exclusive end)
		hl_group = "timerBar", -- Or any other highlight group like "Visual", "Search", "Todo"
	}
)
