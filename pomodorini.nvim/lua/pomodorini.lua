local M = {}

local ns_id = vim.api.nvim_create_namespace("pomodorini")

local function render_progress_bar(progress, length)
	local filled = math.floor(progress * length)
	local empty = length - filled
	return "[" .. string.rep("█", filled) .. string.rep("░", empty) .. "]"
end

M.start_timer = function(duration)
	local bufnr = vim.api.nvim_create_buf(false, true) -- no listed, scratch buffer
	local width = 30
	local height = 3

	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = 1,
		col = vim.o.columns - width - 2,
		style = "minimal",
		border = "rounded",
	}

	local win_id = vim.api.nvim_open_win(bufnr, false, win_opts)
	vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")

	local current_tick = 0
	local total_ticks = duration

	local timer = vim.loop.new_timer()
	timer:start(
		0,
		1000,
		vim.schedule_wrap(function()
			current_tick = current_tick + 1
			local progress = current_tick / total_ticks
			local bar = render_progress_bar(progress, 20)
			local lines = {
				" Pomodorini Timer ",
				"",
				bar .. string.format(" %ds left", total_ticks - current_tick),
			}

			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

			if current_tick >= total_ticks then
				timer:stop()
				timer:close()
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
					" Pomodorini Timer ",
					"",
					" ✅ Done!",
				})
				vim.defer_fn(function()
					vim.api.nvim_win_close(win_id, true)
				end, 2000) -- close after 2 seconds
			end
		end)
	)
end

return M
