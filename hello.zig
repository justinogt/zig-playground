const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});
    try stdout.print("Olá mundo! Arg1: {s}, Agr2: {s}", .{ "11", "22" });

    const hello_world_in_c =
        \\#include <stdio.h>
        \\
        \\int main(int argc, char **argv) {
        \\    printf("hello world\n");
        \\    return 0;
        \\}
    ;
    try stdout.print("{s}", .{hello_world_in_c});
}
