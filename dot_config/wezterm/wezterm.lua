local wezterm = require("wezterm")

local mux = wezterm.mux
local act = wezterm.action

local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

local dark = wezterm.color.get_builtin_schemes()["Github Dark"]
-- one_dark.foreground = "silver"
local light = wezterm.color.get_builtin_schemes()["Github"]
-- one_light.foreground = "black"
config.color_schemes = {
    ["Dark"] = dark,
    ["Light"] = light,
}

local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return "Dark"
end

local function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Dark"
    else
        return "Light"
    end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.font = wezterm.font "FiraCode Nerd Font"
config.font_size = 13

config.window_background_opacity = 0.90
config.text_background_opacity = 1
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
-- config.scrollback_lines = 50000
config.default_workspace = "main"
config.max_fps = 120

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
-- TODO: remove later
-- config.enable_tab_bar = false

config.initial_cols = 160
config.initial_rows = 50
config.window_padding = {
    left = "1cell",
    right = "1cell",
    top = "1.5cell",
    bottom = 0,
}

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    {
        key = "|",
        mods = "LEADER|SHIFT",
        action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        key = "-",
        mods = "LEADER",
        action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
        key = "z",
        mods = "LEADER",
        action = act.TogglePaneZoomState
    },
    {
        key = "h",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Left")
    },
    {
        key = "j",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Down")
    },
    {
        key = "k",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Up")
    },
    {
        key = "l",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Right")
    },
    {
        key = "t",
        mods = "LEADER",
        action = act.SpawnTab("CurrentPaneDomain")
    },
    {
        key = "w",
        mods = "LEADER",
        action = act.CloseCurrentTab { confirm = true }
    },
    {
        key = "[",
        mods = "LEADER",
        action = act.ActivateTabRelative(-1)
    },
    {
        key = "]",
        mods = "LEADER",
        action = act.ActivateTabRelative(1)
    },
    {
        key = "LeftArrow",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Left", 5 },
    },
    {
        key = "DownArrow",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Down", 5 },
    },
    {
        key = "UpArrow",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Up", 5 }
    },
    {
        key = "RightArrow",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Right", 5 },
    },
    {
        key = "s",
        mods = "CMD",
        action = act { SendString = '\x13' }
    },
    {
        key = "/",
        mods = "CMD",
        action = act { SendString = '\x1f' }
    },
    {
        key = "g",
        mods = "CMD",
        action = act { SendString = '\a' }
    }
}

for i = 1, 8 do
    -- CTRL+ALT + number to move to that position
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL|ALT",
        action = wezterm.action.MoveTab(i - 1),
    })
end

return config
