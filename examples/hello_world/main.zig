const std = @import("std");

const flecs = @import("flecs");
const FlecsAllocator = flecs.FlecsAllocator;
const World = flecs.World;
const EcsIter = flecs.EcsIter;

const Move = struct {
    // Move system implementation. System callbacks may be called multiple times,
    // as entities are grouped in tables by which components they have, and each
    // table has its own set of component arrays.
    pub fn run(it: *EcsIter) void {
        const ps = it.field(Position, 0);
        const vs = it.field(Velocity, 1);

        // Iterate entities for the current table
        for (ps, vs) |*p, v| {
            p.*.x += v.x;
            p.*.y += v.y;
        }
    }
};

const Position = struct {
    x: f32,
    y: f32,
};

const Velocity = struct {
    x: f32,
    y: f32,
};

const Eats = struct {};
const Apples = struct {};
const Pears = struct {};

pub fn main() void {
    var buffer: [1024 * 1024 * 5]u8 = .{0} ** (1024 * 1024 * 5);
    var memory = std.heap.FixedBufferAllocator.init(&buffer);
    FlecsAllocator.init(memory.allocator());
    defer FlecsAllocator.deinit();

    // Create the world
    var world = World.init();
    defer world.?.deinit();

    // Register components
    _ = world.?.define.component(Position);
    _ = world.?.define.component(Velocity);
    _ = world.?.define.system(Move, flecs.builtin_components.EcsOnUpdate, .{ Position, Velocity });

    // Register tags (components without a size)
    _ = world.?.define.tag(Eats);
    _ = world.?.define.tag(Apples);
    _ = world.?.define.tag(Pears);

    // Create an entity with name Bob, add Position and food preference
    const bob = world.?.define.entity(.{ .name = "Bob" });
    world.?.set(bob, Position, &.{ .x = 0, .y = 0 });
    world.?.set(bob, Velocity, &.{ .x = 1, .y = 2 });
    world.?.add_pair(bob, Eats, Apples);

    // Run systems twice. Usually this function is called once per frame
    _ = world.?.progress(0);
    _ = world.?.progress(0);

    // See if Bob has moved (he has)
    const p: ?*const Position = world.?.get(bob, Position);
    const stdout = std.io.getStdOut().writer();
    stdout.print("Bob's position is {{{d:.6}, {d:.6}}}\n", .{ p.?.x, p.?.y }) catch @panic("Failed to write");

    // Output
    //  Bob's position is {2.000000, 4.000000}
}
