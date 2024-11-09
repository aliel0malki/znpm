const std = @import("std");

const targets: []const std.Target.Query = &.{
    .{ .cpu_arch = .aarch64, .os_tag = .linux },
    // .{ .cpu_arch = .aarch64, .os_tag = .macos },
    // .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu },
    // .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl },
};

pub fn build(b: *std.Build) !void {
    // const debugging = b.option(bool, "debug", "Enable debugging");
    for (targets) |t| {
        const exe = b.addExecutable(.{
            .name = "znpm",
            .root_source_file = b.path("src/main.zig"),
            .target = b.resolveTargetQuery(t),
            .optimize = .ReleaseFast,
            .strip = true,
            // .optimize = if (debugging == true) .Debug else .ReleaseFast,
            // .strip = if (debugging == true) false else true,
        });

        const target_output = b.addInstallArtifact(exe, .{
            .dest_dir = .{
                .override = .{
                    .custom = try t.zigTriple(b.allocator),
                },
            },
        });

        b.getInstallStep().dependOn(&target_output.step);

        const run = b.addRunArtifact(exe);
        if (b.args) |args| {
            run.addArgs(args);
        }
        const run_step = b.step("run", "Run the app");
        run_step.dependOn(&run.step);
    }
}
