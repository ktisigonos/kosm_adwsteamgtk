//! AdwSteamGtk's custom CSS: the theme's colors as the Adwaita variables AdwSteamGtk's color
//! themes set, in a block of the custom CSS file AdwSteamGtk adds to Steam's skin. The rest of
//! the file stays the user's.

const App = @This();

const std = @import("std");
const kosm = @import("kosm");

/// The custom CSS file holding the block; created when missing.
/// Default: `~/.config/AdwSteamGtk/custom.css`.
file: []const u8 = "~/.config/AdwSteamGtk/custom.css",
/// The Adwaita variables. null: the installed color theme's.
colors: Colors = .{},

/// The Adwaita color variables.
pub const Colors = @import("Colors.zig");

/// Colors from the theme: windows from the background role with its surface steps, text from
/// the foreground role, the accent and the error, success and warning roles, each with readable
/// text from the theme's `contrast.on`; shadows are the theme's `surface.shadow`, alpha
/// included. Friends' states are gray, cyan and green.
pub fn from(theme: kosm.Theme) App {
    const palette = theme.palette;
    const variations = theme.variations;
    const foreground = theme.roles.foreground;
    const background = theme.roles.background;
    const raised = variations.surface.raised.apply(background);
    const overlay = variations.surface.overlay.apply(background);
    const shade = variations.surface.shadow.apply(background);
    const on = variations.contrast.on;
    const bright = variations.lightness.bright;
    return .{ .colors = .{
        .accent_bg = theme.roles.accent,
        .accent_fg = on.apply(theme.roles.accent),
        .accent = bright.apply(theme.roles.accent),
        .destructive_bg = theme.roles.@"error",
        .destructive_fg = on.apply(theme.roles.@"error"),
        .destructive = bright.apply(theme.roles.@"error"),
        .success_bg = theme.roles.success,
        .success_fg = on.apply(theme.roles.success),
        .success = bright.apply(theme.roles.success),
        .warning_bg = theme.roles.warning,
        .warning_fg = on.apply(theme.roles.warning),
        .warning = bright.apply(theme.roles.warning),
        .error_bg = theme.roles.@"error",
        .error_fg = on.apply(theme.roles.@"error"),
        .@"error" = bright.apply(theme.roles.@"error"),
        .window_bg = background,
        .window_fg = foreground,
        .view_bg = variations.surface.sunken.apply(background),
        .view_fg = foreground,
        .headerbar_bg = raised,
        .headerbar_fg = foreground,
        .headerbar_border = variations.line.border.apply(background),
        .headerbar_backdrop = background,
        .headerbar_shade = shade,
        .headerbar_darker_shade = shade,
        .sidebar_bg = raised,
        .sidebar_fg = foreground,
        .sidebar_backdrop = background,
        .sidebar_shade = shade,
        .secondary_sidebar_bg = raised,
        .secondary_sidebar_fg = foreground,
        .secondary_sidebar_backdrop = background,
        .secondary_sidebar_shade = shade,
        .card_bg = raised,
        .card_fg = foreground,
        .card_shade = shade,
        .dialog_bg = overlay,
        .dialog_fg = foreground,
        .popover_bg = overlay,
        .popover_fg = foreground,
        .popover_shade = shade,
        .thumbnail_bg = raised,
        .thumbnail_fg = foreground,
        .shade = shade,
        .user_offline = palette.gray,
        .user_online = palette.cyan,
        .user_ingame = palette.green,
    } };
}

/// How AdwSteamGtk's variables spell a color.
const rgb: kosm.ColorFormat = .init("{}, {}, {}", &.{ .red_255, .green_255, .blue_255 });

/// Writes the set variables as block `kosm` of `file`. Color themes mark theirs `!important`,
/// so these are too.
pub fn apply(self: App, output: *kosm.Output) !void {
    var entries: std.ArrayList(kosm.Value.Entry) = .empty;
    inline for (@typeInfo(Colors).@"struct".field_names) |name| {
        if (@field(self.colors, name)) |color| {
            try entries.append(output.allocator, .{ .key = name ++ "_rgb", .value = try important(output.allocator, .{ .color = color }) });
            if (comptime hasAlpha(name))
                try entries.append(output.allocator, .{ .key = name ++ "_a", .value = try important(output.allocator, .{ .float = color.alpha }) });
        }
    }
    try output.block(.{ .file = self.file, .id = "kosm", .lang = "css", .format = .{ .color = rgb, .float_precision = 2 } }, kosm.Value{ .table = &.{
        .{ .key = "adw", .value = .{ .table = entries.items } },
    } });
}

fn important(allocator: std.mem.Allocator, value: kosm.Value) !kosm.Value {
    return .{ .joined = try allocator.dupe(kosm.Value, &.{ value, .{ .raw = " !important" } }) };
}

fn hasAlpha(comptime name: []const u8) bool {
    for (Colors.with_alpha) |with_alpha| {
        if (std.mem.eql(u8, with_alpha, name)) return true;
    }
    return false;
}

const testing = std.testing;
const adapter = @import("root.zig").css_adapter;

const Fixture = struct {
    tmp: testing.TmpDir,
    arena: std.heap.ArenaAllocator,
    plan: kosm.Plan,
    diagnostics: kosm.Diagnostics = .{},
    warnings: kosm.Warnings = undefined,
    home_buffer: [std.Io.Dir.max_path_bytes]u8 = undefined,
    output: kosm.Output = undefined,

    fn init(fixture: *Fixture, custom_css: ?[]const u8) !void {
        fixture.* = .{ .tmp = testing.tmpDir(.{}), .arena = .init(testing.allocator), .plan = .init(testing.allocator, testing.io) };
        if (custom_css) |text| {
            try fixture.tmp.dir.createDirPath(testing.io, ".config/AdwSteamGtk");
            try fixture.tmp.dir.writeFile(testing.io, .{ .sub_path = ".config/AdwSteamGtk/custom.css", .data = text });
        }
        fixture.warnings = .init(fixture.arena.allocator());
        const length = try fixture.tmp.dir.realPath(testing.io, &fixture.home_buffer);
        fixture.output = .{
            .allocator = fixture.arena.allocator(),
            .home = fixture.home_buffer[0..length],
            .adapters = &.{adapter},
            .plan = &fixture.plan,
            .diagnostics = &fixture.diagnostics,
            .warnings = &fixture.warnings,
            .app = "adwsteamgtk",
        };
    }

    fn deinit(fixture: *Fixture) void {
        fixture.plan.deinit();
        fixture.arena.deinit();
        fixture.tmp.cleanup();
    }

    fn planned(fixture: *Fixture) []const u8 {
        for (fixture.plan.files.items) |file| {
            if (std.mem.eql(u8, file.display_path, "~/.config/AdwSteamGtk/custom.css")) return file.new;
        }
        return "(not planned)";
    }
};

/// The file AdwSteamGtk ships, its example commented out.
const shipped =
    \\/* --- Custom CSS --- */
    \\/* -- DELETE BOTH LINES TO ENABLE
    \\:root
    \\{
    \\    --adw-accent-bg-rgb: 53, 132, 228;
    \\}
    \\-- DELETE BOTH LINES TO ENABLE */
    \\
;

test "variables are written as r, g, b and !important, alphas beside the colors that have them" {
    var fixture: Fixture = undefined;
    try fixture.init(shipped);
    defer fixture.deinit();
    try from(kosm.Theme.from(.{ .palette = .{ .black = kosm.hex("041c26"), .white = kosm.hex("a3c5cc"), .cyan = kosm.hex("2d8699") }, .mode = .dark })).apply(&fixture.output);

    const written = fixture.planned();
    try testing.expect(std.mem.startsWith(u8, written, shipped));
    try testing.expect(std.mem.indexOf(u8, written, "  --adw-accent-bg-rgb: 45, 134, 153 !important;\n") != null);
    try testing.expect(std.mem.indexOf(u8, written, "  --adw-window-bg-rgb: 4, 28, 38 !important;\n  --adw-window-fg-rgb: 163, 197, 204 !important;\n") != null);
    try testing.expect(std.mem.indexOf(u8, written, "  --adw-card-bg-a: 1 !important;\n") != null);
    try testing.expect(std.mem.indexOf(u8, written, "  --adw-shade-a: 0.5 !important;\n") != null);
    try testing.expect(std.mem.indexOf(u8, written, "--adw-error-rgb: ") != null);
    try testing.expect(std.mem.indexOf(u8, written, "--adw-window-bg-a") == null);
}

test "only set variables are written, in a file created when missing" {
    var fixture: Fixture = undefined;
    try fixture.init(null);
    defer fixture.deinit();
    const app: App = .{ .colors = .{ .warning_fg = .{ .lightness = 0, .chroma = 0, .hue = 0, .alpha = 0.8 } } };
    try app.apply(&fixture.output);
    try testing.expect(std.mem.indexOf(u8, fixture.planned(), ":root {\n  --adw-warning-fg-rgb: 0, 0, 0 !important;\n  --adw-warning-fg-a: 0.8 !important;\n}") != null);
}
