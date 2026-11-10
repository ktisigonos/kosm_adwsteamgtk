# kosm_adwsteamgtk

AdwSteamGtk for kosm: the theme's colors as the Adwaita variables of AdwSteamGtk's color
themes, so Steam's Adwaita skin follows the kosmos.

The app writes a block between `/* kosm:begin kosm */` and `/* kosm:end */` into
`~/.config/AdwSteamGtk/custom.css`, the file AdwSteamGtk adds to the skin when its "Custom
CSS" option is on. The rest of the file stays yours. Each set color is a `--adw-<name>-rgb`
variable written `r, g, b !important` (the color themes mark theirs `!important`, so these
must be too). Where Adwaita keeps a color's opacity apart (`--adw-card-bg-a`, the shades,
`--adw-warning-fg-a`), the color's alpha is written there.

After an apply, install the theme again in AdwSteamGtk with "Custom CSS" on, and restart Steam.

`from(theme)` sets windows from black (white in light mode) with its surface steps, text from
white, the accent cyan and the states red, green and yellow, each with readable text from the
theme's `contrast.on`; shadows are the theme's `surface.shadow`, alpha included. Friends'
states are gray, cyan and green.

## Fields

| Field | Default |
|---|---|
| `file` | `~/.config/AdwSteamGtk/custom.css`, created when missing |
| `colors` | every variable of AdwSteamGtk's color themes, named without `--adw-` and `-rgb` (`accent_bg`, `window_fg`, `card_shade`, `user_ingame`, ...); null leaves each to the installed color theme |
