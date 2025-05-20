vim.api.nvim_create_user_command("PomodoriniStart", function(args)
	if args.args then
		local duration = tonumber(args.args) -- Convert the string to a number
		if duration then
			require("pomodorini").start_timer(duration, function()
				-- Start break timer after work timer finishes
				require("pomodorini").start_timer(5)
			end)
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

-- User command to show the window
vim.api.nvim_create_user_command("PomodoriniPauseToggle", function()
	require("pomodorini").pomodorini_pause_toggle()
end, {})

-- hotkeys
vim.api.nvim_set_keymap("n", "<leader>tt", ":PomodoriniStart 25<cr>", { silent = true, desc = "Start Pomodorini" })
vim.api.nvim_set_keymap("n", "<leader>ts", ":PomodoriniShow<cr>", { silent = true, desc = "Show Pomodorini" })
vim.api.nvim_set_keymap("n", "<leader>th", ":PomodoriniHide<cr>", { silent = true, desc = "Hide Pomodorini" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>tp",
	":PomodoriniPauseToggle<cr>",
	{ silent = true, desc = "Toggle Pomodorini Pause" }
)
