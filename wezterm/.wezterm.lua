-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'One Dark (Gogh)'
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
-- config.color_scheme = 'One Dark (Gogh)'
config.color_scheme = 'Abernathy'
config.font_size = 16.0

config.cursor_blink_rate = 0
-- and finally, return the configuration to wezterm
return config
