const flecs = @import("flecs.zig");

pub const World = flecs.ecs_world_t;
pub const Id = flecs.ecs_id_t;
pub const Entity = flecs.ecs_entity_t;
pub const EcsIter = flecs.ecs_iter_t;
pub const SystemFn = fn (*EcsIter) void;
pub const Time = f32;
