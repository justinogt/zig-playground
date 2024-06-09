const std = @import("std");

pub fn readUserAction(userActionBuffer: *std.ArrayList(u8)) ![]u8 {
    const stdin = std.io.getStdIn().reader();
    userActionBuffer.clearRetainingCapacity();
    try stdin.streamUntilDelimiter(userActionBuffer.writer(), '\n', null);
    return if (std.mem.endsWith(u8, userActionBuffer.items, "\r")) userActionBuffer.items[0..(userActionBuffer.items.len - 1)] else userActionBuffer.items;
}

pub fn readButtonPress() !u8 {
    const stdin = std.io.getStdIn().reader();
    return try stdin.readByte();
}
