-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end
-- This is where you actually apply your config choices
if is_darwin() then
	config.font_size = 15.0
else
	config.font_size = 11.0
	config.default_prog = { "powershell.exe", "-NoLogo" }
end

config.enable_kitty_graphics = true

-- For example, changing the color scheme:

config.color_scheme = "Tokyo Night Moon"

-- window deco
config.window_decorations = "NONE|RESIZE"
config.window_padding = {
	top = 10.0,
	bottom = 0.0,
	left = 10.0,
	right = 10.0,
}

-- tab bars:
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.show_tab_index_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.show_close_tab_button_in_tabs = false

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- Use the resolved palette's background color
	local palette = config.resolved_palette
	local background_color = palette and palette.background or "#1b1032"
	local edge_background = background_color -- use theme background for edge

	local background = background_color
	local foreground = "#808080"

	local tabcols = { "#FF6600", "#44DD00", "#0000FF" }

	local active_bg = "#0033dd"
	-- local inactive_bg =

	-- if tab.is_active then
	-- 	background = "#0033dd"
	-- 	foreground = "#eeeeee"
	-- elseif hover then
	-- 	background = "#3b3052"
	-- 	foreground = "#909090"
	-- end

	local colbackground = tabcols[math.fmod(tab.tab_index, #tabcols) + 1]

	local CLOSE = wezterm.nerdfonts.ple_right_half_circle_thick
	local OPEN = wezterm.nerdfonts.ple_left_half_circle_thick
	-- local edge_foreground = background

	-- local title = "" .. tab.active_pane.title .. " | " .. tab.tab_index
	local title = "" .. tab_title(tab) .. " "
	local tip = "" .. (tab.tab_index + 1)

	local edgebg = background_color
	-- local bg = "#0033dd"
	local bg = "#434366"
	-- local bg = wezterm.color.from_hsla(240, 0.1, 0.3, 0)
	local fg = "white"

	if tab.is_active then
		bg = "#5f69a0"
	end

	return {
		{ Background = { Color = edgebg } },
		{ Foreground = { Color = bg } },
		{ Text = " " .. OPEN },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = title },
		-- { Background = { Color = bg } },
		-- { Foreground = { Color = colbackground } },
		-- { Text = OPEN },
		{ Background = { Color = colbackground } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. tip },
		{ Background = { Color = edgebg } },
		{ Foreground = { Color = colbackground } },
		{ Text = CLOSE },
	}
end)

-- My keyamps:
config.debug_key_events = true
config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	{
		key = "e",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "t",
		mods = "LEADER",
		action = act.SpawnTab("DefaultDomain"),
	},
}

-- and finally, return the configuration to wezterm
return config
