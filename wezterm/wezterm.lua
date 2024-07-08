local wezterm = require("wezterm")

-- Maximize on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function()
    local _, _, window = mux.spawn_window({})
    window:gui_window():maximize()
end)

local c = wezterm.config_builder()

-- if  wezterm.target_triple:find("windows") ~= nil then
-- end

if wezterm.target_triple:find("darwin") ~= nil then
    c.font_size = 14
    -- config.freetype_load_target = "Light"
end

if wezterm.target_triple:find("linux") ~= nil then
    c.font_size = 12
    c.window_decorations = "RESIZE"
end

c.font = wezterm.font({
    family = "JetBrainsMono Nerd Font Mono",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

c.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "RESIZE"
c.window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
}
-- For example, changing the color scheme:
-- c.color_scheme = "Mexico Light (base16)"
c.color_scheme = "Kanagawa (Gogh)"

-- Use non gui tab style
c.use_fancy_tab_bar = false
c.tab_max_width = 40
c.switch_to_last_active_tab_when_closing_tab = true
c.tab_bar_at_bottom = true
c.scroll_to_bottom_on_input = true
-- timeout_milliseconds defaults to 1000 and can be omitted
-- config.disable_default_key_bindings = true
-- config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
c.keys = {
    {
        key = "a",
        mods = "CTRL",
        action = wezterm.action_callback(function(_, pane)
            local tab = pane:tab()
            local panes = tab:panes_with_info()
            if #panes == 1 then
                pane:split({
                    direction = "Bottom",
                    size = 0.3,
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
return c
