const std = @import("std");
const data_structures = @import("/data_structures/linked_list.zig");

const LinkedListU32 = data_structures.LinkedList(u32);
pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer gpa.deinit();

    const allocator = gpa.allocator();

    const linked = LinkedListU32.init(allocator);

    linked.append(1);
}
