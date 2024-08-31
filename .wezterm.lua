local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.default_prog = { '/bin/zsh', '-l', '-c', 'tmux attach || tmux' }
config.front_end = 'WebGpu'
config.max_fps = 120

config.colors = {
  foreground = '#CBE0F0',
  -- background = '#000000',
  background = '#191724', -- rose-pine
  cursor_bg = '#47FF9C',
  cursor_border = '#47FF9C',
  cursor_fg = '#011423',
  selection_bg = '#706b4e',
  selection_fg = '#f3d9c4',
  ansi = { '#214969', '#E52E2E', '#44FFB1', '#FFE073', '#0FC5ED', '#a277ff', '#24EAF7', '#24EAF7' },
  brights = { '#214969', '#E52E2E', '#44FFB1', '#FFE073', '#A277FF', '#a277ff', '#24EAF7', '#24EAF7' },
  tab_bar = {
    background = 'rgba(0,0,0,0)',
    active_tab = {
      -- The color of the background area for the tab
      bg_color = 'rgba(0,0,0,0)',
      fg_color = '#47FF9C',
    },
    inactive_tab = {
      -- The color of the background area for the tab
      bg_color = 'rgba(0,0,0,0)',
      fg_color = '#333333',
      italic = true
    }
  },
}

-- config.freetype_load_flags = 'NO_HINTING'
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' })
config.font_size = 14
config.line_height = 1.2
config.cell_width = 1

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 2,
}

config.window_decorations = 'RESIZE | MACOS_FORCE_ENABLE_SHADOW'
config.window_background_opacity = 0.97
config.macos_window_background_blur = 20
config.initial_cols = 160
config.initial_rows = 60

config.send_composed_key_when_left_alt_is_pressed = true

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  { key = 'm', mods = 'CMD', action = wezterm.action.DisableDefaultAssignment },
  { key = 'h', mods = 'CMD', action = wezterm.action.DisableDefaultAssignment },
  { key = "p", mods = "CMD|SHIFT", action = wezterm.action.ActivateCommandPalette },
  { key = ".", mods = "ALT", action = { SendString="dot" } },
  { key = "p", mods = "CMD", action = wezterm.action.SendKey { key = 'p', mods = 'CTRL' } },
  { key = "l", mods = "CMD", action = wezterm.action.SendKey { key = '¬' } },
  { key = "o", mods = "CMD", action = wezterm.action.SendKey { key = 'ø' } },
  { key = 'a', mods = 'CMD', action = wezterm.action.SendKey { key = 'Å' } },
  { key = 'd', mods = 'CMD', action = wezterm.action.SendKey { key = 'Î' } },
  { key = 'i', mods = 'CMD', action = wezterm.action.SendKey { key = 'i' } },
  { key = "/", mods = "CMD", action = wezterm.action.SendKey { key = '/', mods = 'CTRL' } },
  { key = ",", mods = "CMD", action = wezterm.action.SendKey { key = '≤' } },
}

-- return configuration to wezterm
return config
