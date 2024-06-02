const std = @import("std");
const data_structure = @import("data_structure");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var queue = data_structure.Queue(u32).init(allocator);
    defer queue.deinit();

    const teste = queue.peek();
    std.log.info("Teste Jorge: {?}", .{teste});

    try queue.enqueue(1);
    try queue.enqueue(2);

    const teste2 = queue.peek();
    std.log.info("Teste Jorge: {?}", .{teste2});

    try queue.enqueue(3);

    queue.print();

    // _ = queue.dequeue();
    // _ = queue.dequeue();
    // _ = queue.dequeue();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
