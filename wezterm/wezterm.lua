-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font = wezterm.font{
  family = 'JetBrainsMono Nerd Font',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
}
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.freetype_load_target = "Light"
-- config.freetype_render_target = "Normal"
-- config.window_decorations = "RESIZE"
config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}
-- For example, changing the color scheme:
-- config.color_scheme = 'Tomorrow'
-- config.color_scheme = 'Default Light (base16)'
-- config.color_scheme = '3024 (base16)'
config.color_scheme = 'Mexico Light (base16)'

-- and finally, return the configuration to wezterm
return config
