const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;
const curl = @import("curl");
const Easy = curl.Easy;

pub const HttpClient = struct {
    const Self = @This();
    allocator: Allocator,
    easy: Easy,

    // initialize and shi
    pub fn init(allocator: Allocator) !Self {
        const ca_bundle = try curl.allocCABundle(allocator);
        const easy = try Easy.init(allocator, .{ .ca_bundle = ca_bundle });
        return Self{
            .allocator = allocator,
            .easy = easy,
        };
    }

    // getoff that bullshit from heap
    pub fn deinit(self: *Self) void {
        self.easy.deinit();
    }

    pub fn get(self: *Self, url: [:0]const u8) !void {
        const headers = blk: {
            var h = try self.easy.createHeaders();
            errdefer h.deinit();
            // for less data response (just what we need)
            try h.add("Accept", "application/vnd.npm.install-v1+json");
            break :blk h;
        };
        defer headers.deinit();
        try self.easy.setHeaders(headers);
        // for debugging :
        // try self.easy.setVerbose(true);

        const resp = try self.easy.get(url);
        defer resp.deinit();

        const body = resp.body.?.items;
        std.debug.print("{s}", .{body});
    }
};
