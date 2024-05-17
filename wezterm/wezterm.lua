local wezterm = require("wezterm")
local act = wezterm.action
-- Maximize on startup
local mux = wezterm.mux

wezterm.on("gui-startup", function()
    local _, _, window = mux.spawn_window({})
    window:gui_window():maximize()
end)

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    local config = wezterm.config_builder()
end

-- This table will hold the configuration.
local config = {}

local os = wezterm.target_triple
-- if os == 'x86_64-pc-windows-msvc' then
-- end

if os == "x86_64-apple-darwin" or os == "aarch64-apple-darwin" then
    config.font_size = 14
    -- config.freetype_load_target = "Light"
end

if os == "x86_65-unknown-linux-gnu" then
    config.font_size = 12
end

config.font = wezterm.font({
    family = "JetBrainsMono Nerd Font Mono",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "RESIZE"
config.window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
}
-- For example, changing the color scheme:
config.color_scheme = "Mexico Light (base16)"
-- config.color_scheme = "Kanagawa (Gogh)"

-- Use non gui tab style
config.use_fancy_tab_bar = false
config.tab_max_width = 40
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_bar_at_bottom = true
config.scroll_to_bottom_on_input = true
-- timeout_milliseconds defaults to 1000 and can be omitted
-- config.disable_default_key_bindings = true
-- config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    -- https://wezfurlong.org/wezterm/config/default-keys.html?h=disable+key
    -- To get all keybindings from editor itself:
    -- wezterm show-keys --lua
    -- TODO:
    -- alt-tab between tabs
    -- switch to certain tab

    -- { key = 'f',   mods = 'LEADER', action = act.Search { CaseSensitiveString = "" } },
    -- { key = 'c',   mods = 'LEADER', action = act.CopyTo 'Clipboard' },
    -- { key = 'v',   mods = 'LEADER', action = act.PasteFrom 'Clipboard' },
    -- { key = 'q',   mods = 'LEADER', action = act.CloseCurrentTab { confirm = true } },
    --
    -- -- { key = 'j',         mods = 'Option',    action = act.ActivateTabRelative(1) },
    -- -- { key = 'LeftArrow', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
    -- { key = 'Tab', mods = 'LEADER', action = act.ActivateLastTab },
    --
    -- { key = '1',   mods = 'LEADER', action = act.ActivateTab(0) },
    -- { key = '2',   mods = 'LEADER', action = act.ActivateTab(1) },
    -- { key = '3',   mods = 'LEADER', action = act.ActivateTab(2) },
    -- { key = '4',   mods = 'LEADER', action = act.ActivateTab(3) },
    -- { key = '5',   mods = 'LEADER', action = act.ActivateTab(4) },
    -- { key = '6',   mods = 'LEADER', action = act.ActivateTab(5) },
    -- { key = '7',   mods = 'LEADER', action = act.ActivateTab(6) },
    -- { key = '8',   mods = 'LEADER', action = act.ActivateTab(7) },
    -- { key = '9',   mods = 'LEADER', action = act.ActivateTab(8) },
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
return config
