const std = @import("std");
const npmRegistry = @import("../__registry__/npm.zig");

pub fn install(package: []const u8) !void {
    const allocator = std.heap.page_allocator;
    const url = try std.fmt.allocPrint(allocator, "https://registry.npmjs.org/{s}", .{package});
    const s_url = try std.mem.Allocator.dupeZ(allocator, u8, url);
    try npmRegistry.npmRegistry(allocator, s_url);
}
