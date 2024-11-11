//
//  ZNPM
//  Version: v0.1.0
//      Created by: aliel0malki
//          Last Updated: 2024-11-9
//  License: MIT
//
const std = @import("std");
const CLI = @import("cli.zig");

pub fn main() !void {
    try CLI.parser();
}
