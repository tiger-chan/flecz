const std = @import("std");
const flecs = @import("flecs.zig");
const types = @import("types.zig");
const EcsId = @import("ecs_id.zig").EcsId;
const EcsIter = @import("iter.zig");

pub fn entity(ecs: *types.World, desc: flecs.ecs_entity_desc_t) types.Entity {
    return flecs.ecs_entity_init(ecs, &desc);
}

pub fn component(ecs: *types.World, comptime T: type) flecs.ecs_id_t {
    if (@sizeOf(T) == 0) {
        @compileError("Components must contain data, use tagDefine instead");
    }
    const ecs_id = EcsId(T);
    const edesc = std.mem.zeroInit(flecs.ecs_entity_desc_t, .{
        .id = ecs_id.id,
        .use_low_id = true,
        .name = ecs_id.name.ptr,
        .symbol = ecs_id.name.ptr,
    });

    // zig fmt: off
    const desc = std.mem.zeroInit(flecs.ecs_component_desc_t, .{
        .entity = flecs.ecs_entity_init(ecs, &edesc),
        .type = std.mem.zeroInit(flecs.ecs_type_info_t, .{
            .size = ecs_id.size,
            .alignment = ecs_id.alignment
        })
    });
    // zig fmt: on

    ecs_id.id = flecs.ecs_component_init(ecs, &desc);
    std.debug.assert(ecs_id.id != 0); // "failed to create component"
    return ecs_id.id;
}

pub fn tag(ecs: *types.World, comptime T: type) flecs.ecs_id_t {
    if (@sizeOf(T) > 0) {
        @compileError("Components must not contain data, use componentDefine instead");
    }

    const ecs_id = EcsId(T);
    const desc = std.mem.zeroInit(flecs.ecs_entity_desc_t, .{
        .id = ecs_id.id,
        .name = ecs_id.name.ptr,
    });

    ecs_id.id = flecs.ecs_entity_init(ecs, &desc); // "failed to create entity"
    std.debug.assert(ecs_id.id != 0);
    return ecs_id.id;
}

fn entityComb(lo: anytype, hi: @TypeOf(lo)) @TypeOf(lo) {
    return (hi << 32) + (lo & 0xFFFF_FFFF);
}

pub fn pair(pred: anytype, obj: @TypeOf(pred)) @TypeOf(pred) {
    return flecs.ECS_PAIR | entityComb(obj, pred);
}

fn queryFromTypes(comptime Cs: anytype) [:0]const u8 {
    comptime var parts: [Cs.len * 2][]const u8 = undefined;
    comptime var i: usize = 0;
    inline for (Cs) |c| {
        parts[i] = EcsId(c).name;
        i += 1;
    }
    const fmt = std.fmt.comptimePrint("{s}", .{parts[0..i]});
    const copy = fmt[2..(fmt.len - 2)] ++ "";
    return copy;
}

fn callback(comptime System: type) (fn (*anyopaque) callconv(.C) void) {
    return struct {
        fn exec(ptr: *anyopaque) callconv(.C) void {
            const it: *types.EcsIter = @ptrCast(@alignCast(ptr));
            var iter = EcsIter.init(it);
            System.run(&iter);
        }
    }.exec;
}

pub fn system(ecs: *flecs.ecs_world_t, comptime System: type, phase: types.Entity, comptime Comps: anytype) types.Entity {
    const ecs_id = EcsId(System);

    // zig fmt: off
    const add_id: [3]types.Entity = .{
        if (phase != 0) pair(flecs.EcsDependsOn, phase) else 0,
        phase,
        0
    };

    const edesc = std.mem.zeroInit(flecs.ecs_entity_desc_t, .{
        .id = ecs_id.id,
        .name = ecs_id.name.ptr,
        .add = &add_id,
    });
    // zig fmt: on

    const expr: [*]const u8 = queryFromTypes(Comps).ptr;
    const desc = std.mem.zeroInit(flecs.ecs_system_desc_t, .{
        .entity = flecs.ecs_entity_init(ecs, &edesc),
        .callback = callback(System),
        .query = .{
            .expr = expr,
        },
    });

    ecs_id.id = flecs.ecs_system_init(ecs, &desc);
    std.debug.assert(ecs_id.id != 0); // "failed to create system"
    return ecs_id.id;
}
