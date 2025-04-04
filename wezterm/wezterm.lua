local win_frame_state = "RESIZE"
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Maximize on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- Set window titlebar the same as pane title
wezterm.on("format-window-title", function(tab)
	return tab.active_pane.title
end)

-- if  wezterm.target_triple:find("windows") ~= nil then
-- end

if wezterm.target_triple:find("darwin") ~= nil then
	config.font_size = 14
	config.window_decorations = "RESIZE"
	config.freetype_load_target = "Light"
end

if wezterm.target_triple:find("linux") ~= nil then
	config.font_size = 10.8
	config.window_decorations = "RESIZE"
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
config.font = wezterm.font({
	-- family = "JetBrainsMono Nerd Font Mono",
	-- family = "JetBrains Mono Medium",
	-- family = "Fira Code",
	-- family = "Hack Nerd Font Mono",
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	-- weight = "Medium",
	-- weight = "Regular",
	-- weight = "Light",
	-- weight = "ExtraLight",
})

config.max_fps = 144
config.scroll_to_bottom_on_input = true
config.window_padding = { left = "0cell", right = "0cell", top = "0cell", bottom = "0cell" }
config.line_height = 1.2

-- config.color_scheme = "Default Dark (base16)"
-- config.color_scheme = "Alabaster"
config.color_scheme = "Mexico Light (base16)"
config.colors = {
	-- background = "#232326",
	background = "#F6F6F6",
	-- background = "#E6E6E6",
	foreground = "#000000",
}

config.tab_max_width = 40
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true

-- timeout_milliseconds defaults to 1000 and can be omitted
-- config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action_callback(function(_, pane)
			local tab = pane:tab()
			local panes = tab:panes_with_info()
			if #panes == 1 then
				pane:split({
					direction = "Right",
					size = 0.40,
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
		key = "k",
		mods = "LEADER",
		action = wezterm.action_callback(function(_, pane)
         local overrides = window:get_config_overrides()
         if overrides.window_decorations == 'RESIZE' then
            overrides.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
         else
            overrides.window_decorations = 'RESIZE'
         end

         -- wezterm.reload_configuration()
		end),
	},
}

return config
