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

test "stack should behave as a stack" {
    var stack = data_structure.Stack(u32).init(std.testing.allocator);

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    try std.testing.expectEqual(@as(u32, 3), stack.pop() orelse 0);
    try std.testing.expectEqual(@as(u32, 2), stack.pop() orelse 0);
    try std.testing.expectEqual(@as(u32, 1), stack.pop() orelse 0);
}

test "stack should deinit" {
    var stack = data_structure.Stack(u32).init(std.testing.allocator);

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    try std.testing.expectEqual(@as(usize, 3), stack.length);

    stack.deinit();

    try std.testing.expect(stack.head == null);

    try std.testing.expectEqual(@as(usize, 0), stack.length);
}

test "queue should behave as a queue" {
    var queue = data_structure.Queue(u32).init(std.testing.allocator);

    try queue.enqueue(1);
    try queue.enqueue(2);
    try queue.enqueue(3);

    try std.testing.expectEqual(@as(u32, 1), queue.dequeue() orelse 0);
    try std.testing.expectEqual(@as(u32, 2), queue.dequeue() orelse 0);
    try std.testing.expectEqual(@as(u32, 3), queue.dequeue() orelse 0);
}

test "queue should deinit" {
    var queue = data_structure.Queue(u32).init(std.testing.allocator);
    try queue.enqueue(1);
    try queue.enqueue(2);
    try queue.enqueue(3);

    try std.testing.expectEqual(@as(usize, 3), queue.length);

    queue.deinit();

    try std.testing.expect(queue.head == null);
    try std.testing.expect(queue.tail == null);

    try std.testing.expectEqual(@as(usize, 0), queue.length);
}
