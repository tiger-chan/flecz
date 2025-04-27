const std = @import("std");
const flecs = @import("flecs.zig");
const FlecsAllocator = @import("allocator.zig");
const types = @import("types.zig");
const EcsId = @import("ecs_id.zig").EcsId;
const EcsIter = @import("iter.zig");
const define = @import("define.zig");
pub const World = @import("world.zig");

fn set_os_api() void {
    flecs.ecs_os_set_api_defaults();
    var os = flecs.ecs_os_get_api();
    os.malloc_ = &FlecsAllocator.malloc;
    os.calloc_ = &FlecsAllocator.calloc;
    os.realloc_ = &FlecsAllocator.realloc;
    os.free_ = &FlecsAllocator.free;
    flecs.ecs_os_set_api(&os);
}

fn reset_os_api() void {
    flecs.ecs_os_set_api_defaults();
}

var ecs_world_init_count: u32 = 0;
pub fn init() ?*types.World {
    if (ecs_world_init_count == 0) {
        set_os_api();
    }
    ecs_world_init_count += 1;
    return flecs.ecs_init();
}

pub fn deinit(ecs: *flecs.ecs_world_t) void {
    std.debug.assert(ecs_world_init_count > 0);

    if (flecs.ecs_fini(ecs) != 0) @panic("Failed to deinit ecs");
    ecs_world_init_count -= 1;

    if (ecs_world_init_count == 0) {
        reset_os_api();
    }
}

pub fn set(ecs: *types.World, entity: types.Entity, comptime T: type, value: *const T) void {
    const ecs_id = EcsId(T);
    const comp_size = @sizeOf(T);
    flecs.ecs_set_id(ecs, entity, ecs_id.id, comp_size, value);
}

/// Get an immutable pointer to a component.
/// This operation obtains a const pointer to the requested component. The
/// operation accepts the component entity id.
///
/// This operation can return inherited components reachable through an `IsA`
/// relationship.
///
/// @param world The world.
/// @param entity The entity.
/// @param id The id of the component to get.
/// @return The component pointer, NULL if the entity does not have the component.
///
/// @see get_mut()
pub fn get(ecs: *types.World, subject: types.Entity, comptime T: type) ?*const T {
    const raw = flecs.ecs_get_id(ecs, subject, EcsId(T).id);
    return @ptrCast(@alignCast(raw));
}

/// Get a mutable pointer to a component.
/// This operation obtains a mutable pointer to the requested component. The
/// operation accepts the component entity id.
///
/// Unlike get_id(), this operation does not return inherited components.
///
/// @param world The world.
/// @param entity The entity.
/// @param id The id of the component to get.
/// @return The component pointer, NULL if the entity does not have the component.
pub fn get_mut(ecs: *types.World, subject: types.Entity, comptime T: type) ?*T {
    const raw = flecs.ecs_get_mut_id(ecs, subject, EcsId(T).id);
    return @ptrCast(@alignCast(raw));
}

pub fn add_pair(ecs: *types.World, subject: types.Entity, comptime A: type, comptime B: type) void {
    flecs.ecs_add_id(ecs, subject, define.pair(EcsId(A).id, EcsId(B).id));
}

/// Progress a world.
/// This operation progresses the world by running all systems that are both
/// enabled and periodic on their matching entities.
///
/// An application can pass a delta_time into the function, which is the time
/// passed since the last frame. This value is passed to systems so they can
/// update entity values proportional to the elapsed time since their last
/// invocation.
///
/// When an application passes 0 to delta_time, progress() will automatically
/// measure the time passed since the last frame. If an application does not uses
/// time management, it should pass a non-zero value for delta_time (1.0 is
/// recommended). That way, no time will be wasted measuring the time.
///
/// @param world The world to progress.
/// @param delta_time The time passed since the last frame.
/// @return false if ecs_quit() has been called, true otherwise.
pub fn progress(ecs: *types.World, delta_time: types.Time) bool {
    return flecs.ecs_progress(ecs, delta_time);
}
