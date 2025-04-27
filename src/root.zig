//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const testing = std.testing;

pub const builtin_components = @import("flecs/builtin_components.zig");

const define = @import("flecs/define.zig");
pub const EcsIter = @import("flecs/iter.zig");
pub const World = @import("flecs/world.zig");
pub const FlecsAllocator = @import("flecs/allocator.zig");


test "ecs int test" {
    var buffer: [1024 * 1024 * 4]u8 = .{0} ** (1024 * 1024 * 4);
    var memory = std.heap.FixedBufferAllocator.init(&buffer);
    FlecsAllocator.init(memory.allocator());
    defer FlecsAllocator.deinit();

    var world = World.init();
    defer world.?.deinit();

    try testing.expect(world != null);
}

