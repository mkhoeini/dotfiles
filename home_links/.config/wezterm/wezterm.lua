local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Twilight"
-- config.color_scheme = "Palenight (Gogh)"
config.font = wezterm.font("RobotoMono Nerd Font")
config.font_size = 13
config.line_height = 1.3

config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.native_macos_fullscreen_mode = true

config.pane_focus_follows_mouse = true
config.prefer_to_spawn_tabs = true
config.scrollback_lines = 99999

config.unix_domains = {
	{
		name = "default",
	},
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect default` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.default_gui_startup_args = { "connect", "default" }

config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = "#202020",
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
			   local text_color = "#000000"
			   local bar_background = "#333333"
			   local active_background = "#C0FD50"
			   local inactive_background = "#8A8A8A"
			   local hover_background = "#DADADA"

			   local background = inactive_background
			   if tab.is_active then
				   background = active_background
			   elseif hover then
				   background = hover_background
			   end

			   local title = (tab.tab_index + 1) .. ": " .. tab_title(tab)

			   -- ensure that the titles fit in the available space,
			   -- and that we have room for the edges.
			   title = " " .. wezterm.truncate_right(title, max_width - 4) .. " "

			   return {
				   { Background = { Color = background } },
				   { Foreground = { Color = bar_background } },
				   { Text = SOLID_RIGHT_ARROW },
				   { Background = { Color = background } },
				   { Foreground = { Color = text_color } },
				   { Text = title },
				   { Background = { Color = bar_background } },
				   { Foreground = { Color = background } },
				   { Text = SOLID_RIGHT_ARROW },
			   }
end)

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5000 }
config.keys = {
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
		}),
	},
	{
		key = "a",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
				name = "activate_pane",
				one_shot = true,
		}),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
				local color_scheme_menu = {}
				for name in pairs(wezterm.get_builtin_color_schemes()) do
					table.insert(color_scheme_menu, { label = name, id = name })
				end
				table.sort(color_scheme_menu, function(a, b) return a.label < b.label end)

				win:perform_action(
					wezterm.action.InputSelector {
						title = "Choose color scheme",
						choices = color_scheme_menu,
						action = wezterm.action_callback(function(window, pane, id, label)
								window:set_config_overrides { color_scheme = id }
						end),
					},
					pane
				)
		end),
	},
}

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},

	-- Defines the keys that are active in our activate-pane mode.
	-- 'activate_pane' here corresponds to the name="activate_pane" in
	-- the key assignments above.
	activate_pane = {
		{ key = "LeftArrow", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "h", action = wezterm.action.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "l", action = wezterm.action.ActivatePaneDirection("Right") },

		{ key = "UpArrow", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "k", action = wezterm.action.ActivatePaneDirection("Up") },

		{ key = "DownArrow", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	},
}

wezterm.on("update-right-status", function(window)
			   local name = window:active_key_table()
			   if name then
				   name = "TABLE: " .. name
			   end
			   window:set_right_status(name or "")
end)

return config
