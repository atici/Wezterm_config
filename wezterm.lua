local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = {
    set_environment_variables = {
        XDG_CONFIG_HOME = "C:/dev",
        XDG_DATA_HOME   = "C:/dev",
    },
    color_scheme = "Tokyo Night Moon",
    default_prog = { "pwsh", "-NoLogo" },
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    font = wezterm.font("Cascadia Code NF"),
    font_size = 9.8,
    enable_csi_u_key_encoding = true,
    allow_win32_input_mode = false,
    window_padding = { left = "0", right = "0", top = "0", bottom = "0", },
    keys = {
        -- Config
        { key = "c",          mods = "CTRL|ALT", action = act.SpawnCommandInNewTab({ args = { "nvim", wezterm.config_dir .. "/wezterm.lua" } }), },
        { key = 'x',          mods = "ALT",      action = act.ActivateCopyMode },
        -- Tab Control
        { key = "q",          mods = "ALT",      action = act.CloseCurrentPane({ confirm = false }), },
        { key = "t",          mods = "ALT",      action = act.SpawnTab("CurrentPaneDomain"), },
        -- Splits
        { key = "s",          mods = "ALT",      action = act.SplitHorizontal, },
        { key = "v",          mods = "ALT",      action = act.SplitVertical, },
        -- Split Navigation
        { key = "j",          mods = "ALT",      action = act.ActivatePaneDirection("Down"), },
        { key = "h",          mods = "ALT",      action = act.ActivatePaneDirection("Left"), },
        { key = "l",          mods = "ALT",      action = act.ActivatePaneDirection("Right"), },
        { key = "k",          mods = "ALT",      action = act.ActivatePaneDirection("Up"), },
        { key = "DownArrow",  mods = "ALT",      action = act.AdjustPaneSize({ "Down", 10 }), },
        { key = "LeftArrow",  mods = "ALT",      action = act.AdjustPaneSize({ "Left", 10 }), },
        { key = "RightArrow", mods = "ALT",      action = act.AdjustPaneSize({ "Right", 10 }), },
        { key = "UpArrow",    mods = "ALT",      action = act.AdjustPaneSize({ "Up", 10 }), },
        -- Scrolling
        { key = "u",          mods = "ALT",      action = act.ScrollByLine(-10), },
        { key = "d",          mods = "ALT",      action = act.ScrollByLine(10), },
        { key = "PageUp",     mods = "",         action = act.ScrollByPage(-1), },
        { key = "PageDown",   mods = "",         action = act.ScrollByPage(1), },
        -- Tab Navigation
        { key = "o",          mods = "ALT",      action = act.ActivateLastTab },
        { key = "[",          mods = "ALT",      action = act.ActivateTabRelative(-1) },
        { key = "]",          mods = "ALT",      action = act.ActivateTabRelative(1) },
        { key = "[",          mods = "CTRL|ALT", action = act.MoveTabRelative(-1) },
        { key = "]",          mods = "CTRL|ALT", action = act.MoveTabRelative(1) },
        -- Tab Renaming
        {
            key = "r",
            mods = "ALT",
            action = act.PromptInputLine {
                description = "Enter new name for tab",
                action = wezterm.action_callback(function(window, pane, line)
                    if line and line ~= "" then
                        window:active_tab():set_title(line)
                    end
                end),
            },
        },
    },
    max_fps = 240,
}

-- Tab Swithing by ALT + Num
for i = 1, 9 do
    -- ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = act.ActivateTab(i - 1),
    })
end

-- CTRL+ALT + number to move tab to that position
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL|ALT",
        action = wezterm.action.MoveTab(i - 1),
    })
end

-- Start Maximized
wezterm.on('gui-startup', function(window)
    local tab, pane, window = mux.spawn_window(cmd or {})
    local gui_window = window:gui_window();
    gui_window:maximize()
end)

return config
