local M = {}

M.setup = function()
	-- nothing
end

M.start_timer = function(time)
	vim.defer_fn(function()
		vim.notify(time .. "s", vim.log.levels.INFO)
	end, time * 1000)
end

return M
