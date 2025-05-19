local M = {}

M.setup = function()
	-- User command to hide the window
end

local ns_id = vim.api.nvim_create_namespace("pomodorini")

-- State tracking for buffer, window, timer, lines and visibility
local state = {
	timer = nil,
	win_id = nil,
	bufnr = nil,
	lines = {},
	hidden = false,
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
	vim.bo[bufnr].readonly = true
	vim.bo[bufnr].buflisted = false
	vim.bo[bufnr].filetype = "pomodorini"

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
	state.win_id = win_id
	state.hidden = false
end

M.start_timer = function(duration)
	-- Stop previous timer if running
	if state.timer then
		state.timer:stop()
		state.timer:close()
		state.timer = nil
	end

	M.pomodorini_create()
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

	local current_tick = 0
	local total_ticks = duration * 60

	-- Start timer
	local timer = vim.loop.new_timer()
	state.timer = timer

	--TODO make sure first draw happens before the 1 sec sleep

	timer:start(
		0,
		1000,
		vim.schedule_wrap(function()
			local progress = current_tick / total_ticks
			local bar = render_progress_bar(progress, 20)
			local lines = {
				" Pomodorini Timer ",
				"",
				bar .. string.format(" %ds left", total_ticks - current_tick),
			}

			state.lines = lines
			vim.bo[bufnr].modifiable = true
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			vim.bo[bufnr].modifiable = false

			if current_tick >= total_ticks then
				timer:stop()
				timer:close()
				state.timer = nil

				local done_lines = {
					" Pomodorini Timer ",
					" ✅Done!",
					" [R]estart [B]reak [C]lose",
				}
				state.lines = done_lines
				vim.bo[bufnr].modifiable = true
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, done_lines)
				vim.bo[bufnr].modifiable = false

				-- Auto-show window if hidden
				if state.hidden then
					vim.cmd("PomodoriniShow")
				end
			end

			current_tick = current_tick + 1
		end)
	)
end

M.pomodorini_hide = function()
	if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
		vim.api.nvim_win_hide(state.win_id)
		state.win_id = nil
		state.hidden = true
	end
end

M.pomodorini_show = function()
	if state.hidden and state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
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

		local win_id = vim.api.nvim_open_win(state.bufnr, false, win_opts)
		state.win_id = win_id
		state.hidden = false

		-- Re-apply keymaps (if necessary)
		vim.keymap.set("n", "h", function()
			vim.cmd("PomodoriniHide")
		end, { buffer = state.bufnr, nowait = true, silent = true })

		-- Re-render last known lines
		if state.lines then
			vim.bo[state.bufnr].modifiable = true
			vim.api.nvim_buf_set_lines(state.bufnr, 0, -1, false, state.lines)
			vim.bo[state.bufnr].modifiable = false
		end
	end
end
-- User command to show the window
-- M.pomodorini_show = function()
-- 	if state.hidden and state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
-- 		local width = 30
-- 		local height = 3
-- 		local win_opts = {
-- 			relative = "editor",
-- 			width = width,
-- 			height = height,
-- 			row = 1,
-- 			col = vim.o.columns - width - 2,
-- 			style = "minimal",
-- 			border = "rounded",
-- 		}
--
-- 		local win_id = vim.api.nvim_open_win(state.bufnr, false, win_opts)
-- 		state.win_id = win_id
-- 		state.hidden = false
--
-- 		-- Re-apply 'h' keymap after reopening
-- 		vim.keymap.set("n", "h", function()
-- 			vim.cmd("PomodoriniHide")
-- 		end, { buffer = state.bufnr, nowait = true, silent = true })
--
-- 		-- Restore last known lines (in case buffer cleared)
-- 		if state.lines then
-- 			vim.bo[state.bufnr].modifiable = true
-- 			vim.api.nvim_buf_set_lines(state.bufnr, 0, -1, false, state.lines)
-- 			vim.bo[state.bufnr].modifiable = false
-- 		end
-- 	end
-- end

return M
