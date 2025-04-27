const flecs = @import("flecs.zig");
const std = @import("std");

inline fn lastIndexOfScalar(comptime T: type, slice: []const T, value: T) ?usize {
    inline for (0..slice.len) |idx| {
        const i: usize = slice.len - 1 - idx;
        if (slice[i] == value) return i;
    }
    return null;
}

inline fn shortName(comptime T: type) []const u8 {
    const full = @typeName(T);
    const last_dot = lastIndexOfScalar(u8, full, '.');
    return if (last_dot) |i| full[(i + 1)..] else full;
}

inline fn fullName(comptime T: type) []const u8 {
    return @typeName(T);
}

pub fn EcsId(comptime T: type) type {
    return struct {
        pub var id: flecs.ecs_id_t = 0;
        pub const size = @sizeOf(T);
        pub const alignment = @alignOf(T);
        pub const name = shortName(T);
        pub const full_name = fullName(T);
    };
}
