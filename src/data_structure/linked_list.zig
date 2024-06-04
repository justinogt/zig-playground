const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        const Node = struct {
            next: ?*Node = null,
            prev: ?*Node = null,
            value: T,
        };

        head: ?*Node,
        tail: ?*Node,
        length: usize,
        allocator: std.mem.Allocator,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{
                .allocator = allocator,
                .length = 0,
                .head = null,
                .tail = null,
            };
        }

        pub fn isEmpty(self: *Self) bool {
            if (self.head) {
                return false;
            }
            return true;
        }

        pub fn append(self: *Self, value: T) !*Node {
            var node = try self.allocator.create(Node);
            node.value = value;
            node.prev = null;
            node.next = null;
            self.length += 1;

            if (self.head == null) {
                self.head = node;
                self.tail = node;
                return node;
            }

            if (self.tail) |tail| {
                tail.next = node;
                node.prev = tail;
            }

            self.tail = node;
            return node;
        }

        pub fn removeNode(self: *Self, node: *Node) void {
            if (node.prev == null) {
                self.head = node.next;
            } else if (node.next == null) {
                self.tail = node.prev;
            } else {
                node.prev.?.next = node.next.?;
                node.next.?.prev = node.prev.?;
            }
            self.allocator.destroy(node);
        }

        pub fn getAt(self: *Self, index: usize) ?T {
            if (index == 0 and self.head != null) {
                return self.head.?.value;
            }
            if (index >= self.length) {
                return null;
            }

            var cursor = self.head;
            var cursorIndex = index;
            while (cursor) |current| : (cursor = current.next) {
                if (cursorIndex == 0) {
                    return current.value;
                }
                cursorIndex -= 1;
            }
            return null;
        }

        pub fn clear(self: *Self) void {
            var cursor = self.head;
            while (cursor) |current| {
                cursor = current.next;
                self.allocator.destroy(current);
            }
            self.length = 0;
            self.head = null;
            self.tail = null;
        }

        pub fn print(self: *Self) !void {
            var currOptional = self.head;
            while (currOptional) |curr| : (currOptional = curr.next) {
                std.log.info("-> {}", .{curr.value});
            }
        }
    };
}
