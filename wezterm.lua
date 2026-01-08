local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = {
    color_scheme = "Tokyo Night Moon",
    default_prog = { "pwsh" },
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    font = wezterm.font("Cascadia Code NF"),
    font_size = 9.8,
    enable_csi_u_key_encoding = true,
    allow_win32_input_mode = false,
    window_padding = {
        left = "0",
        right = "0",
        top = "0",
        bottom = "0",
    },
    keys = {
        {
            action = wezterm.action.ActivatePaneDirection("Down"),
            key = "j",
            mods = "ALT",
        },
        {
            action = wezterm.action.ActivatePaneDirection("Left"),
            key = "h",
            mods = "ALT",
        },
        {
            action = wezterm.action.ActivatePaneDirection("Right"),
            key = "l",
            mods = "ALT",
        },
        {
            action = wezterm.action.ActivatePaneDirection("Up"),
            key = "k",
            mods = "ALT",
        },
        -- {
        --     action = wezterm.action.ActivateTabRelative(-1),
        --     key = "Tab",
        --     mods = "CTRL|SHIFT",
        -- },
        -- {
        --     action = wezterm.action.ActivateTabRelative(1),
        --     key = "Tab",
        --     mods = "CTRL",
        -- },
        {
            action = wezterm.action.AdjustPaneSize({ "Down", 10 }),
            key = "DownArrow",
            mods = "ALT|SHIFT",
        },
        {
            action = wezterm.action.AdjustPaneSize({ "Left", 10 }),
            key = "LeftArrow",
            mods = "ALT|SHIFT",
        },
        {
            action = wezterm.action.AdjustPaneSize({ "Right", 10 }),
            key = "RightArrow",
            mods = "ALT|SHIFT",
        },
        {
            action = wezterm.action.AdjustPaneSize({ "Up", 10 }),
            key = "UpArrow",
            mods = "ALT|SHIFT",
        },
        {
            action = wezterm.action.CloseCurrentPane({ confirm = false }),
            key = "q",
            mods = "ALT",
        },
        {
            action = wezterm.action.ScrollByLine(-10),
            key = "UpArrow",
            mods = "SHIFT",
        },
        {
            action = wezterm.action.ScrollByLine(10),
            key = "DownArrow",
            mods = "SHIFT",
        },
        {
            action = wezterm.action.ScrollByPage(-1),
            key = "PageUp",
        },
        {
            action = wezterm.action.ScrollByPage(1),
            key = "PageDown",
        },
        {
            action = wezterm.action.SpawnCommandInNewTab({ args = { "nvim", wezterm.config_dir .. "/wezterm.lua" } }),
            key = ",",
            mods = "CTRL|ALT",
        },
        {
            action = wezterm.action.SpawnTab("CurrentPaneDomain"),
            key = "t",
            mods = "ALT",
        },
        {
            action = wezterm.action.SplitHorizontal,
            key = "RightArrow",
            mods = "CTRL|ALT",
        },
        {
            action = wezterm.action.SplitVertical,
            key = "DownArrow",
            mods = "CTRL|ALT",
        },
    },
    max_fps = 240,
}

-- Tab Swithing by ALT + Num
for i = 1, 9 do
  -- ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

-- Start Maximized
wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:maximize()
end)

return config
