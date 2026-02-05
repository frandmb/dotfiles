--#region setup
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
config.leader = { key = "a", mods = "CTRL" }
--#endregion

-- #region font config
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 11
-- #endregion

config.default_prog = { "nu" }
config.max_fps = 120
-- config.enable_wayland = false
config.front_end = "WebGpu"
-- #region theme
-- tabs config
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
local tab_max_width = 20

local function get_tab_title(tab_info)
	local title = tab_info.tab_title
	if not title or #title == 0 then
		title = tab_info.active_pane.title
	end
	local pad_count = tab_max_width - #title
	return title .. string.rep(" ", pad_count)
end
wezterm.on("format-tab-title", function(tab)
	local title = wezterm.truncate_left(get_tab_title(tab), tab_max_width)
	return title
end)

config.colors = {
	foreground = "#CBE0F0",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },

	tab_bar = {
		inactive_tab_edge = "#44FFB1",
	},
}

config.window_frame = {
	active_titlebar_bg = "none",
	inactive_titlebar_bg = "none",
	font_size = 10,
}
wezterm.on("window-focus-changed", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.allow_win32_input_mode then
		window:maximize()
		overrides.allow_win32_input_mode = true
		window:set_config_overrides(overrides)
	end
end)
-- #endregion

-- resurrect.state_manager.periodic_save({
-- 	interval_seconds = 300,
-- 	save_workspaces = true,
-- 	save_windows = true,
-- 	save_tabs = true,
-- })
--
-- wezterm.on("gui-startup", function()
-- 	resurrect.state_manager.resurrect_on_gui_startup()
-- end)
-- resurrect.state_manager.set_max_nlines(10)
--
config.keys = {
	{
		mods = "CTRL",
		key = "q",
		action = wezterm.action.QuitApplication,
	},

	--#region resurrect
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
			resurrect.tab_state.save_tab_action()
		end),
	},
	{
		key = "r",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					window = win:mux_window(), -- THIS IS THE NEW PART
					relative = true,
					restore_text = true,
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
				}
				if type == "workspace" then
					local state = resurrect.state_manager.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.state_manager.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.state_manager.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	},
	--#endregion
}

return config
