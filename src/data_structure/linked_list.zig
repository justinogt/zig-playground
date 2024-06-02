const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        const Node = struct {
            next: ?*Node,
            value: T,
        };

        head: ?*Node,
        tail: ?*Node,
        length: usize,
        alloc: std.mem.Allocator,

        pub fn init(alloc: std.mem.Allocator) Self {
            return .{
                .alloc = alloc,
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

        pub fn append(self: *Self, value: T) !void {
            var node = try self.alloc.create(Node);
            node.value = value;
            self.length += 1;

            if (self.head == null) {
                self.head = node;
                self.tail = node;
                return;
            }

            self.tail.?.next = node;
            self.tail = node;
        }

        pub fn clear(self: *Self) void {
            if (self.head) |head| {
                self.alloc.destroy(head);
            }
        }

        pub fn print(self: *Self) !void {
            const stdout = std.io.getStdOut().writer();
            var currOptional = self.head;
            while (currOptional) |curr| : (currOptional = curr.next) {
                try stdout.print("- {}", .{curr.value});
            }
        }
    };
}
