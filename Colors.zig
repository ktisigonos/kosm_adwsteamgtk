//! The Adwaita color variables AdwSteamGtk's color themes set, named without `--adw-` and
//! `-rgb`. Each is written `r, g, b`; where Adwaita has a matching `-a` variable, it takes the
//! color's alpha. null: the installed color theme's.

const kosm = @import("kosm");

/// The background of accented widgets: suggested buttons, selections.
accent_bg: ?kosm.Color = null,
/// Text on `accent_bg`.
accent_fg: ?kosm.Color = null,
/// Accented text and icons on ordinary backgrounds.
accent: ?kosm.Color = null,
/// The background of destructive buttons.
destructive_bg: ?kosm.Color = null,
/// Text on `destructive_bg`.
destructive_fg: ?kosm.Color = null,
/// Destructive text and icons.
destructive: ?kosm.Color = null,
/// The background of success messages and level bars.
success_bg: ?kosm.Color = null,
/// Text on `success_bg`.
success_fg: ?kosm.Color = null,
/// Success text and icons.
success: ?kosm.Color = null,
/// The background of warnings.
warning_bg: ?kosm.Color = null,
/// Text on `warning_bg`; its alpha is `--adw-warning-fg-a`.
warning_fg: ?kosm.Color = null,
/// Warning text and icons.
warning: ?kosm.Color = null,
/// The background of errors.
error_bg: ?kosm.Color = null,
/// Text on `error_bg`.
error_fg: ?kosm.Color = null,
/// Error text and icons.
@"error": ?kosm.Color = null,
/// The window background.
window_bg: ?kosm.Color = null,
/// Text on windows.
window_fg: ?kosm.Color = null,
/// The background of views: lists, the library grid.
view_bg: ?kosm.Color = null,
/// Text in views.
view_fg: ?kosm.Color = null,
/// The header bar, search bar and tab bar.
headerbar_bg: ?kosm.Color = null,
/// Text on the header bar.
headerbar_fg: ?kosm.Color = null,
/// The header bar's border.
headerbar_border: ?kosm.Color = null,
/// The header bar while the window is unfocused.
headerbar_backdrop: ?kosm.Color = null,
/// The header bar's shadow; its alpha is `--adw-headerbar-shade-a`.
headerbar_shade: ?kosm.Color = null,
/// The header bar's darker shadow; its alpha is `--adw-headerbar-darker-shade-a`.
headerbar_darker_shade: ?kosm.Color = null,
/// The sidebar of split views.
sidebar_bg: ?kosm.Color = null,
/// Text on the sidebar.
sidebar_fg: ?kosm.Color = null,
/// The sidebar while the window is unfocused.
sidebar_backdrop: ?kosm.Color = null,
/// The sidebar's shadow; its alpha is `--adw-sidebar-shade-a`.
sidebar_shade: ?kosm.Color = null,
/// The secondary sidebar.
secondary_sidebar_bg: ?kosm.Color = null,
/// Text on the secondary sidebar.
secondary_sidebar_fg: ?kosm.Color = null,
/// The secondary sidebar while the window is unfocused.
secondary_sidebar_backdrop: ?kosm.Color = null,
/// The secondary sidebar's shadow; its alpha is `--adw-secondary-sidebar-shade-a`.
secondary_sidebar_shade: ?kosm.Color = null,
/// Cards and boxed lists; its alpha is `--adw-card-bg-a`.
card_bg: ?kosm.Color = null,
/// Text on cards.
card_fg: ?kosm.Color = null,
/// The cards' shadow; its alpha is `--adw-card-shade-a`.
card_shade: ?kosm.Color = null,
/// Dialogs.
dialog_bg: ?kosm.Color = null,
/// Text in dialogs.
dialog_fg: ?kosm.Color = null,
/// Popovers and menus.
popover_bg: ?kosm.Color = null,
/// Text in popovers.
popover_fg: ?kosm.Color = null,
/// The popovers' shadow; its alpha is `--adw-popover-shade-a`.
popover_shade: ?kosm.Color = null,
/// Thumbnails.
thumbnail_bg: ?kosm.Color = null,
/// Text on thumbnails.
thumbnail_fg: ?kosm.Color = null,
/// Shadows elsewhere; its alpha is `--adw-shade-a`.
shade: ?kosm.Color = null,
/// Friends who are offline.
user_offline: ?kosm.Color = null,
/// Friends who are online.
user_online: ?kosm.Color = null,
/// Friends who are in a game.
user_ingame: ?kosm.Color = null,

/// The colors whose alpha Adwaita keeps in a variable of its own, `--adw-<name>-a`.
pub const with_alpha = [_][]const u8{ "warning_fg", "headerbar_shade", "headerbar_darker_shade", "sidebar_shade", "secondary_sidebar_shade", "card_bg", "card_shade", "popover_shade", "shade" };
