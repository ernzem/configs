local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Maximize on startup
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function()
-- 	local _, _, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)

-- Set window titlebar the same as pane title
wezterm.on("format-window-title", function(tab)
	return tab.active_pane.title
end)

-- if  wezterm.target_triple:find("windows") ~= nil then
-- end

if wezterm.target_triple:find("darwin") ~= nil then
	config.font = wezterm.font({
		-- family = "Hack Nerd Font",
		-- family = "JetBrains Mono",
		-- family = "JetBrains Mono Light",
		-- family = "JetBrains Mono Regular",
		family = "JetBrains Mono Medium",
		-- family = "JetBrains Mono SemiBold",
		-- family = "Fira Code Retina",
		-- family = "Fira Code Medium",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
		-- weight = "DemiBold",
		-- weight = "Bold",
		-- weight = "Retina",
		-- stretch="UltraExpanded",
		-- stretch="UltraCondensed",
	})
	-- config.font_size = 15
	config.font_size = 14
	-- config.font_size = 14.4
	-- config.window_decorations = "RESIZE"
	config.freetype_load_target = "Light"
	config.freetype_load_flags = "NO_HINTING"
	-- config.freetype_load_flags = 'DEFAULT'
	-- config.freetype_render_target = 'HorizontalLcd'
	-- config.front_end = "OpenGL"
	-- config.line_height = 1.1
end

if wezterm.target_triple:find("linux") ~= nil then
	config.font = wezterm.font({
		family = "JetBrains Mono",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
		-- weight = "DemiBold",
	})
	config.font_size = 11.6
	-- config.font_size = 12
	config.window_decorations = "RESIZE"
	config.freetype_load_target = "Light"
	config.freetype_load_flags = "NO_HINTING"
	-- config.line_height = 1.2

	-- Maximize on startup
	local mux = wezterm.mux
	wezterm.on("gui-startup", function()
		local _, _, window = mux.spawn_window({})
		window:gui_window():maximize()
	end)
end

config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
}

config.max_fps = 144
config.scroll_to_bottom_on_input = true
config.window_padding = { left = "0cell", right = "0cell", top = "0cell", bottom = "0cell" }

-- config.color_scheme = "Default Dark (base16)"
-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = "Mexico Light (base16)"
-- config.color_scheme = 'Tokyo Night Storm'
config.colors = {
	-- background = "#14161b",
	-- background = "#232326",
	-- background = "#E6E6E6",
	background = "#FFFFFF",
	foreground = "#000000",
}

config.tab_max_width = 40
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true

config.leader = { key = "Tab", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "k",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},
	{
		key = "Space",
		mods = "SHIFT",
		action = wezterm.action_callback(function(_, pane)
			local tab = pane:tab()
			local panes = tab:panes_with_info()
			if #panes == 1 then
				pane:split({
					direction = "Right",
					size = 0.4,
				})
			elseif not panes[1].is_zoomed then
				panes[1].pane:activate()
				tab:set_zoomed(true)
			elseif panes[1].is_zoomed then
				tab:set_zoomed(false)
				panes[2].pane:activate()
			end
		end),
	},
	{
		key = "1",
		mods = "LEADER",
		action = act.ActivateTab(0),
	},
	{
		key = "2",
		mods = "LEADER",
		action = act.ActivateTab(1),
	},
	{
		key = "3",
		mods = "LEADER",
		action = act.ActivateTab(2),
	},
	{
		key = "4",
		mods = "LEADER",
		action = act.ActivateTab(3),
	},
	{
		key = "5",
		mods = "LEADER",
		action = act.ActivateTab(4),
	},
	{
		key = "6",
		mods = "LEADER",
		action = act.ActivateTab(5),
	},
	{
		key = "7",
		mods = "LEADER",
		action = act.ActivateTab(6),
	},
	{
		key = "8",
		mods = "LEADER",
		action = act.ActivateTab(7),
	},
	{
		key = "9",
		mods = "LEADER",
		action = act.ActivateTab(8),
	},
	{
		key = "0",
		mods = "LEADER",
		action = act.ActivateTab(9),
	},
}

return config
