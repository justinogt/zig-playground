const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    //var input: [128]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Enter your expression in the format of xx+yy\n", .{});

    var buffer = std.ArrayList(u8).init(allocator);
    defer buffer.deinit();

    try stdin.streamUntilDelimiter(buffer.writer(), '\n', null);

    var iterInput = std.mem.splitAny(u8, buffer.items, "+,-,/,*");

    while (iterInput.next()) |value| {
        try stdout.print("Value: {s}\n", .{value});
    }
}
