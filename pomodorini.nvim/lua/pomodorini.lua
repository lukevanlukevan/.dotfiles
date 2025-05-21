local M = {}

M.setup = function()
	-- User command to hide the window
end

WIDTH = 39

local ns_id = vim.api.nvim_create_namespace("pomodorini")

-- State tracking for buffer, window, timer, lines and visibility
local state = {
	timer = nil,
	win_id = nil,
	bufnr = nil,
	lines = {},
	hidden = false,
	paused = false,
	current_tick = nil,
	total_ticks = nil,
	paused_at_tick = 0, -- New: Stores the tick count when the timer was paused
}

local function render_progress_bar(progress, length)
	local filled = math.floor(progress * length)
	local empty = length - filled
	return "[" .. string.rep("█", filled) .. string.rep("░", empty) .. "]"
end

M.pomodorini_create = function()
	-- Close previous window if still open
	if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
		vim.api.nvim_win_close(state.win_id, true)
		state.win_id = nil
	end

	-- Create new buffer and floating window
	local bufnr = vim.api.nvim_create_buf(false, true)
	state.bufnr = bufnr

	vim.bo[bufnr].modifiable = false
	vim.bo[bufnr].buflisted = false
	vim.bo[bufnr].filetype = "pomodorini"

	local width = WIDTH
	local height = 2

	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = 1,
		col = vim.o.columns - width - 2,
		style = "minimal",
		border = "rounded",
		title = "🍅 Pomodorini",
	}

	local win_id = vim.api.nvim_open_win(bufnr, false, win_opts)
	state.win_id = win_id
	state.hidden = false
end

local function start_timer_for(duration_minutes, on_done, start_tick)
	state.paused = false
	-- Stop any previous timer
	if state.timer then
		state.timer:stop()
		state.timer:close()
		state.timer = nil
	end

	-- Initialize current_tick to start_tick if provided, otherwise 0
	state.current_tick = start_tick or 0
	-- Calculate total ticks based on the full duration in minutes
	state.total_ticks = duration_minutes * 60

	local timer = vim.loop.new_timer()
	state.timer = timer

	timer:start(
		0, -- Start immediately
		1000, -- Tick every 1000ms (1 second)
		vim.schedule_wrap(function()
			-- Check if the timer has completed
			if state.current_tick >= state.total_ticks then
				timer:stop()
				timer:close()
				state.timer = nil

				local done_lines = {
					" [r]estart [b]reak [c]lose",
					" Timer complete.",
				}
				state.lines = done_lines
				vim.bo[state.bufnr].modifiable = true
				vim.api.nvim_buf_set_lines(state.bufnr, 0, -1, false, done_lines)
				vim.bo[state.bufnr].modifiable = false

				-- Show the window if it was hidden when the timer completed
				if state.hidden then
					vim.cmd("PomodoriniShow")
				end

				-- Execute the on_done callback if provided
				if on_done then
					on_done()
				end
				return
			end

			-- Calculate progress and render the progress bar
			local progress = state.current_tick / state.total_ticks
			local bar = render_progress_bar(progress, 20)

			-- Calculate remaining time
			local secondsleft = state.total_ticks - state.current_tick
			local minutesleft = math.floor(secondsleft / 60)
			local modsecs = math.fmod(secondsleft, 60)

			-- Format the lines to display in the window
			local lines = {
				" [r]estart [b]reak [c]lose",
				bar .. string.format(" %dm %ds left", minutesleft, modsecs),
			}
			state.lines = lines
			vim.bo[state.bufnr].modifiable = true
			vim.api.nvim_buf_set_lines(state.bufnr, 0, -1, false, lines)
			vim.bo[state.bufnr].modifiable = false

			-- ONLY increment current_tick if the timer is NOT paused
			if not state.paused then
				state.current_tick = state.current_tick + 1
			end
		end)
	)
end

M.start_timer = function(duration, on_done)
	-- Create the window if it doesn't exist or is invalid
	if not state.bufnr or not vim.api.nvim_buf_is_valid(state.bufnr) then
		M.pomodorini_create()
	end

	local bufnr = state.bufnr
	local win_id = state.win_id

	vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")

	-- Keymaps: close with 'c'
	vim.keymap.set("n", "c", function()
		if vim.api.nvim_win_is_valid(win_id) then
			vim.api.nvim_win_close(win_id, true)
		end
		if state.timer then
			state.timer:stop()
			state.timer:close()
			state.timer = nil
		end
		state.win_id = nil
		state.hidden = true
	end, { buffer = bufnr, nowait = true, silent = true })

	-- Keymap: hide with 'h'
	vim.keymap.set("n", "h", function()
		vim.cmd("PomodoriniHide")
	end, { buffer = bufnr, nowait = true, silent = true })

	-- Keymap: restart with 'r' (starts a 25-min timer, then a 1-min break)
	vim.keymap.set("n", "r", function()
		start_timer_for(25, function()
			start_timer_for(1)
		end)
	end, { buffer = bufnr, nowait = true, silent = true, noremap = true })

	-- Keymap: break with 'b' (starts a 5-min break, then a 1-min break)
	vim.keymap.set("n", "b", function()
		start_timer_for(5, function()
			start_timer_for(1)
		end)
	end, { buffer = bufnr, nowait = true, silent = true, noremap = true })

	-- Start the initial timer
	start_timer_for(duration, on_done)
end

M.pomodorini_pause_toggle = function()
	if state.paused then
		-- Unpausing: Restart the timer from where it was paused
		state.paused = false
		-- Use the original total duration (state.total_ticks / 60) and the tick it was paused at
		start_timer_for(state.total_ticks / 60, nil, state.paused_at_tick)
	else
		-- Pausing: Stop the current timer and record the current tick
		if state.timer then
			state.timer:stop()
			state.timer:close()
			state.timer = nil
		end
		state.paused_at_tick = state.current_tick -- Store the current tick when pausing
		state.paused = true
	end
end

M.pomodorini_hide = function()
	if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
		vim.api.nvim_win_hide(state.win_id)
		state.win_id = nil
		state.hidden = true
	end
end

M.pomodorini_show = function()
	-- Check if the current window buffer matches our timer buffer,
	-- otherwise, the window might have been replaced by Neovim.
	if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
		local current_buf = vim.api.nvim_win_get_buf(state.win_id)
		if current_buf ~= state.bufnr then
			-- The buffer was replaced, so treat the window as invalid
			state.win_id = nil
			state.hidden = true
		end
	end

	-- Only show if currently hidden and the buffer is valid
	if state.hidden and state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
		local width = WIDTH
		local height = 2
		local win_opts = {
			relative = "editor",
			width = width,
			height = height,
			row = 1,
			col = vim.o.columns - width - 2,
			style = "minimal",
			border = "rounded",
			title = "🍅 Pomodorini",
		}

		local win_id = vim.api.nvim_open_win(state.bufnr, false, win_opts)
		state.win_id = win_id
		state.hidden = false

		-- Re-apply keymaps (important if the buffer was re-opened)
		vim.keymap.set("n", "h", function()
			vim.cmd("PomodoriniHide")
		end, { buffer = state.bufnr, nowait = true, silent = true })

		-- Re-render last known lines to update the display
		if state.lines then
			vim.bo[state.bufnr].modifiable = true
			vim.api.nvim_buf_set_lines(state.bufnr, 0, -1, false, state.lines)
			vim.bo[state.bufnr].modifiable = false
		end
	end
end

return M
