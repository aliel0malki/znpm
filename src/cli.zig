const clap = @import("clap");
const std = @import("std");
const CONSTANTS = @import("CONSTANTS.zig");

pub fn parser() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const params = comptime clap.parseParamsComptime(
        \\-h, --help             Display this help and exit.
        \\-i, --install <string> Install a package.
        \\-d, --delete <string>  Delete a package.
        \\-v, --version          Display version.
        \\
    );
    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &params, clap.parsers.default, .{
        .diagnostic = &diag,
        .allocator = gpa.allocator(),
    }) catch |err| {
        diag.report(std.io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help != 0) {
        try std.io.getStdOut().writer().print("ZNPM CLI v{s}\n    repository: github.com/aliel0malki/znpm\n\n", .{@import("CONSTANTS.zig").CURRENT_VERSION});
        try clap.help(std.io.getStdOut().writer(), clap.Help, &params, .{});
        return;
    }
    if (res.args.install) |package| {
        try @import("__commands__/install.zig").install(package);
        return;
    }
    if (res.args.delete) |s| {
        std.debug.print("--delete = {s}\n", .{s});
        return;
    }
    if (@as(u8, res.args.version) != 0) {
        std.debug.print("v{s}\n", .{CONSTANTS.CURRENT_VERSION});
        return;
    }

    try std.io.getStdOut().writer().print("ZNPM CLI v{s}\n    repository: github.com/aliel0malki/znpm\n\n", .{@import("CONSTANTS.zig").CURRENT_VERSION});
    try clap.help(std.io.getStdOut().writer(), clap.Help, &params, .{});
}
