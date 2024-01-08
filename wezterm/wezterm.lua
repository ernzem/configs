local wezterm = require 'wezterm'

-- Maximize on startup
local mux = wezterm.mux
wezterm.on('gui-startup', function()
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

if os == 'x86_64-apple-darwin' or os == 'aarch64-apple-darwin' then
    config.font_size = 14
    config.freetype_load_target = "Light"
end

if os == 'x86_65-unknown-linux-gnu' then
    config.font_size = 12
    config.freetype_render_target = "Normal"
end

-- This is where you actually apply your config choices
config.font = wezterm.font {
    family = 'JetBrainsMono Nerd Font',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
}

config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "RESIZE"
config.window_padding = {
    left = '0cell',
    right = '0cell',
    top = '0cell',
    bottom = '0cell',
}
-- For example, changing the color scheme:
-- config.color_scheme = 'Mexico Light (base16)'
config.color_scheme = 'Kanagawa (Gogh)'

return config
