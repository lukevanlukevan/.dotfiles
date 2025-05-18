vim.api.nvim_create_user_command("PomodoriniStart", function(args)
	if args.args then
		local duration = tonumber(args.args) -- Convert the string to a number
		if duration then
			require("pomodorini").start_timer(duration)
		else
			vim.notify("Please provide a valid number", vim.log.levels.ERROR)
		end
	end
end, {
	nargs = 1, -- Require exactly one argument
})

vim.api.nvim_create_user_command("PomodoriniHide", function()
	require("pomodorini").pomodorini_hide()
end, {})

-- User command to show the window
vim.api.nvim_create_user_command("PomodoriniShow", function()
	require("pomodorini").pomodorini_show()
end, {})
