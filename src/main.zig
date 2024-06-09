const std = @import("std");
const data_structure = @import("data_structure");
const utils = @import("utils");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var userActionBuffer = std.ArrayList(u8).init(allocator);
    defer userActionBuffer.deinit();

    while (true) {
        var userAction = try printMenu(&userActionBuffer);
        if (std.mem.eql(u8, userAction, "q") or std.mem.eql(u8, userAction, "Q")) {
            break;
        }

        if (std.mem.eql(u8, userAction, "1")) {
            var game = TicTacToe().init(&userActionBuffer);
            try game.gameLoop();
        }
    }
}

pub fn TicTacToe() type {
    return struct {
        const Self = @This();

        userActionBuffer: *std.ArrayList(u8),

        pub fn init(userActionBuffer: *std.ArrayList(u8)) Self {
            return .{ .userActionBuffer = userActionBuffer };
        }

        pub fn gameLoop(self: *Self) !void {
            _ = self;
            var counter: u32 = 0;
            while (true) {
                const stdout = std.io.getStdOut().writer();
                // try stdout.print("\x1B[2J\x1B[H", .{});
                try stdout.print("Game - Tic Tac Toe : Counter: {}\n", .{counter});

                var userAction = try utils.readButtonPress();
                try stdout.print("User action was: {}\n", .{userAction});

                counter += 1;

                // if (std.mem.eql(u8, userAction, "q") or std.mem.eql(u8, userAction, "Q")) {
                //     break;
                // }
            }
        }
    };
}

fn printMenu(userActionBuffer: *std.ArrayList(u8)) ![]u8 {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("\n---== Main Menu ==---\n", .{});
    try stdout.print("(1) TicTacToe\n", .{});
    try stdout.print("(q or Q) Quit\n", .{});

    try stdout.print("\nEnter your option: ", .{});
    return try utils.readUserAction(userActionBuffer);
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
