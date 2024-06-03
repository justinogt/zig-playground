const std = @import("std");

pub fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();

        const Node = struct {
            value: T,
            next: ?*Node,
        };

        allocator: std.mem.Allocator,
        length: u32,
        head: ?*Node,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{ .allocator = allocator, .length = 0, .head = null };
        }

        pub fn deinit(self: *Self) void {
            var cursor = self.head;
            while (cursor) |current| {
                cursor = current.next;
                self.allocator.destroy(current);
            }
            self.length = 0;
            self.head = null;
        }

        pub fn push(self: *Self, value: T) !void {
            var node = try self.allocator.create(Node);
            node.value = value;
            node.next = null;
            self.length += 1;

            if (self.head) |head| {
                node.next = head;
                self.head = node;
                return;
            }

            self.head = node;
        }

        pub fn pop(self: *Self) ?T {
            if (self.head) |head| {
                defer self.allocator.destroy(head);
                self.head = head.next;
                self.length -= 1;
                return head.value;
            } else {
                return null;
            }
        }
    };
}
