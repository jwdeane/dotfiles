local wezterm = require("wezterm")
local config = wezterm.config_builder()

--config.font = wezterm.font("Departure Mono")
--config.font = wezterm.font("SpaceMono Nerd Font")
config.font_size = 14.0
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.color_scheme = "Catppuccin Mocha"
config.hide_tab_bar_if_only_one_tab = true
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.native_macos_fullscreen_mode = false
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = "#202020",
}
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "4cell",
	right = "4cell",
	top = "1.5cell",
	bottom = "0.8cell",
}

-- Keys
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

return config
