const std = @import("std");

pub fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();

        const Node = struct {
            value: T,
            next: ?*Node,
        };

        allocator: std.mem.Allocator,
        head: ?*Node,
        tail: ?*Node,
        length: usize,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{
                .allocator = allocator,
                .head = null,
                .tail = null,
                .length = 0,
            };
        }
        pub fn deinit(self: *Self) void {
            var cursor = self.head;
            while (cursor) |current| {
                cursor = current.next;
                self.allocator.destroy(current);
            }
        }

        pub fn enqueue(self: *Self, value: T) !void {
            var node = try self.allocator.create(Node);
            node.value = value;
            node.next = null;
            self.length += 1;

            if (self.head == null) {
                self.head = node;
                self.tail = node;
                return;
            }

            self.tail.?.next = node;
            self.tail = node;
        }

        pub fn peek(self: *Self) ?T {
            if (self.head) |head| {
                return head.value;
            }
            return null;
        }

        pub fn dequeue(self: *Self) ?T {
            if (self.head) |head| {
                defer self.allocator.destroy(head);

                self.head = head.next;
                self.length -= 1;
                return head.value;
            }
            return null;
        }

        pub fn length(self: *Self) usize {
            return self.length;
        }

        pub fn print(self: *Self) void {
            var cursor = self.head;
            while (cursor) |current| : (cursor = current.next) {
                std.log.info("--> {}, next: {?}", .{ current.value, current.next });
            }
        }
    };
}
