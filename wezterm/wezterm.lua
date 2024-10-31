local wezterm = require("wezterm")

-- Maximize on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function()
    local _, _, window = mux.spawn_window({})
    window:gui_window():maximize()
end)

local config = wezterm.config_builder()

-- if  wezterm.target_triple:find("windows") ~= nil then
-- end

if wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 14
    -- config.window_decorations = "RESIZE"
    -- config.freetype_load_target = "Light"
end

if wezterm.target_triple:find("linux") ~= nil then
    config.font_size = 10.8
    config.window_decorations = "RESIZE"
end

config.font = wezterm.font({
    family = "JetBrainsMono Nerd Font Mono",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
}

-- config.color_scheme = "Mexico Light (base16)"
-- c.color_scheme = "Kanagawa (Gogh)"
config.color_scheme = 'Default Dark (base16)'
config.colors = {
    background = "#232326",
}

-- Use non gui tab style
config.use_fancy_tab_bar = false
config.tab_max_width = 40
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_bar_at_bottom = true
config.scroll_to_bottom_on_input = true
config.hide_tab_bar_if_only_one_tab = true

-- timeout_milliseconds defaults to 1000 and can be omitted
-- config.disable_default_key_bindings = true
-- config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = "F1",
        -- mods = "CTRL",
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
}
return config
