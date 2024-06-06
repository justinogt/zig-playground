const std = @import("std");
const data_structure = @import("data_structure");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();
    _ = allocator;

    const stdin = std.io.getStdIn().reader();
    _ = stdin;

    try printMenu();
}

fn printMenu() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("---== Main Menu ==---\n", .{});
    try stdout.print("(1) TicTacToe\n", .{});

    const stdin = std.io.getStdIn().reader();
    var inputBuf: [4]u8 = undefined;
    var input: []u8 = undefined;

    while (true) {
        try stdout.print("\nEnter your option: ", .{});
        if (stdin.readUntilDelimiter(&inputBuf, '\n')) |value| {
            input = value;
            break;
        } else |err| {
            try stdout.print("\n--> Error Jorge: {!}\n", .{err});
            continue;
        }
    }

    try stdout.print("\n Value typed: {s}\n", .{input});
}

test "linkedList should behave as a linkedList" {
    var linkedList = data_structure.LinkedList(u32).init(std.testing.allocator);

    const node1 = try linkedList.append(1);
    const node2 = try linkedList.append(2);
    const node3 = try linkedList.append(3);

    linkedList.removeNode(node1);

    const valueAt1 = linkedList.getAt(1) orelse 0;

    try std.testing.expectEqual(@as(u32, 3), valueAt1);

    linkedList.removeNode(node2);
    linkedList.removeNode(node3);
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
