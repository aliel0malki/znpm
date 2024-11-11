const std = @import("std");
const http = @import("../__utils__/http.zig");

pub fn npmRegistry(allocator: std.mem.Allocator, url: [:0]const u8) !void {
    var fetch_req = try http.HttpClient.init(allocator);
    defer fetch_req.deinit();

    try fetch_req.get(url);
}
