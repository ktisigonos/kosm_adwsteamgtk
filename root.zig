//! AdwSteamGtk: the theme's colors as Adwaita variables in the custom CSS it adds to Steam.

const std = @import("std");

/// The custom CSS block; build one with `from`.
pub const App = @import("App.zig");
/// Colors from the theme.
pub const from = App.from;
/// The adapter the app writes the block with, so a config needs only this package.
pub const css_adapter = @import("kosm_css").adapter;

test {
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(App);
    std.testing.refAllDecls(App.Colors);
}
