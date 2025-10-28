-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { "/usr/bin/distrobox", "enter", "--name", "base", "--", "zsh" }
config.window_close_confirmation = "NeverPrompt"
config.font = wezterm.font("EnvyCodeR Nerd Font")
config.font_size = 18.0
return config
