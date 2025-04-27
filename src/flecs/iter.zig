const std = @import("std");
const flecs = @import("flecs.zig");
const types = @import("types.zig");

const Self = @This();

raw_iter: *types.EcsIter,

pub fn init(it: *types.EcsIter) Self {
    return .{ .raw_iter = it };
}

pub fn count(self: *Self) usize {
    return @intCast(self.raw_iter.count);
}

/// Get data for field.
/// This operation retrieves a pointer to an array of data that belongs to the
/// term in the query. The index refers to the location of the term in the query,
/// and starts counting from zero.
///
/// For example, the query `"Position, Velocity"` will return the `Position` array
/// for index 0, and the `Velocity` array for index 1.
///
/// When the specified field is not owned by the entity this function returns a
/// pointer instead of an array. This happens when the source of a field is not
/// the entity being iterated, such as a shared component (from a prefab), a
/// component from a parent, or another entity. The ecs_field_is_self() operation
/// can be used to test dynamically if a field is owned.
///
/// When a field contains a sparse component, use the ecs_field_at function. When
/// a field is guaranteed to be set and owned, the ecs_field_self() function can be
/// used. ecs_field_self() has slightly better performance, and provides stricter
/// validity checking.
///
/// The provided size must be either 0 or must match the size of the type
/// of the returned array. If the size does not match, the operation may assert.
/// The size can be dynamically obtained with ecs_field_size().
///
/// An example:
///
/// @code
/// while (ecs_query_next(&it)) {
///   Position *p = ecs_field(&it, Position, 0);
///   Velocity *v = ecs_field(&it, Velocity, 1);
///   for (int32_t i = 0; i < it->count; i ++) {
///     p[i].x += v[i].x;
///     p[i].y += v[i].y;
///   }
/// }
/// @endcode
///
/// @param index The index of the field.
/// @return A pointer to the data of the field.
pub fn field(self: *Self, comptime T: type, index: i8) []T {
    const raw = flecs.ecs_field_w_size(self.raw_iter, @sizeOf(T), index);
    const arr: [*] T = @ptrCast(@alignCast(raw));
    return arr[0..self.count()];
}
