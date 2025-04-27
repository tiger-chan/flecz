//! A world is the container for all ECS data and supporting features.
//! Applications can have multiple worlds, though in most cases will only need
//! one. Worlds are isolated from each other, and can have separate sets of
//! systems, components, modules etc.
//!
//! If an application has multiple worlds with overlapping components, it is
//! common (though not strictly required) to use the same component ids across
//! worlds, which can be achieved by declaring a global component id variable.
//! To do this in the C API, see the entities/fwd_component_decl example. The
//! C++ API automatically synchronizes component ids between worlds.
//!
//! Component id conflicts between worlds can occur when a world has already
//! used an id for something else. There are a few ways to avoid this:
//!
//! - Ensure to register the same components in each world, in the same order.
//! - Create a dummy world in which all components are preregistered which
//! initializes the global id variables.
//!
//! In some use cases, typically when writing tests, multiple worlds are
//! created and deleted with different components, registered in different
//! order. To ensure isolation between tests, the C++ API has a `flecs::reset`
//! function that forces the API to ignore the old component ids.

const std = @import("std");
const fc = @import("core.zig");
const ft = @import("types.zig");
const fd = @import("define.zig");
const flecs = @import("flecs.zig");

const Self = @This();

_world: *ft.World,
define: Define,

pub fn init() ?Self {
    const world = fc.init() orelse return null;
    return .{
        ._world = world,
        .define = Define.init(world),
    };
}

pub fn deinit(self: *Self) void {
    fc.deinit(self._world);
}

/// Add a paired component to an entity.
/// This operation adds a single (component) id to an entity. If the entity
/// already has the id, this operation will have no side effects.
///
/// @param entity The entity.
/// @param A The type of the first of the pair to add.
/// @param B The type of the second of the pair to add.
pub fn add_pair(self: *Self, subject: ft.Entity, comptime A: type, comptime B: type) void {
    fc.add_pair(self._world, subject, A, B);
}

/// Get an immutable pointer to a component.
/// This operation obtains a const pointer to the requested component.
///
/// This operation can return inherited components reachable through an `IsA`
/// relationship.
///
/// @param entity The entity.
/// @param T The type of the component to get.
/// @return The component pointer, NULL if the entity does not have the component.
///
/// @see get_mut()
pub fn get(self: *const Self, entity: ft.Entity, comptime T: type) ?*const T {
    return fc.get(self._world, entity, T);
}

/// Get a mutable pointer to a component.
/// This operation obtains a mutable pointer to the requested component.
///
/// Unlike get(), this operation does not return inherited components.
///
/// @param entity The entity.
/// @param T The type of the component to get.
/// @return The component pointer, NULL if the entity does not have the component.
pub fn get_mut(self: *Self, entity: ft.Entity, comptime T: type) ?*T {
    return fc.get_mut(self._world, entity, T);
}

/// Set the value of a component.
/// This operation allows an application to set the value of a component. The
/// operation will not modify the value of the passed in component. If the
/// component has a copy hook registered, it will be used to copy in the
/// component.
///
/// If the provided entity is 0, a new entity will be created.
///
/// @param entity The entity.
/// @param T The type of the component to set.
/// @param value The pointer to the value.
pub fn set(self: *Self, entity: ft.Entity, comptime T: type, value: *const T) void {
    fc.set(self._world, entity, T, value);
}

pub fn progress(self: *Self, delta_time: ft.Time) bool {
    return fc.progress(self._world, delta_time);
}

const Define = struct {
    _world: *ft.World,

    fn init(world: *ft.World) Define {
        return .{ ._world = world };
    }

    /// Declare & define a component.
    ///
    /// Example:
    ///
    /// @code
    /// world.define.component(Position);
    /// @endcode
    ///
    pub fn component(self: Define, comptime T: type) ft.Id {
        return fd.component(self._world, T);
    }

    /// Find or create an entity.
    /// This operation creates a new entity, or modifies an existing one. When a name
    /// is set in the EntityDesc.name field and EntityDesc.entity is
    /// not set, the operation will first attempt to find an existing entity by that
    /// name. If no entity with that name can be found, it will be created.
    ///
    /// If both a name and entity handle are provided, the operation will check if
    /// the entity name matches with the provided name. If the names do not match,
    /// the function will fail and return 0.
    ///
    /// If an id to a non-existing entity is provided, that entity id become alive.
    ///
    /// See the documentation of EntityDesc for more details.
    ///
    /// @param desc Entity init parameters.
    /// @return A handle to the new or existing entity, or 0 if failed.
    ///
    pub fn entity(self: Define, desc: EntityDesc) ft.Entity {
        const val: flecs.ecs_entity_desc_t = .{
            .id = desc.id,
            .parent = desc.parent,
            .name = desc.name,
            .sep = desc.sep,
            .root_sep = desc.root_sep,
            .symbol = desc.symbol,
            .use_low_id = desc.use_low_id,
            .add = desc.add,
            .add_expr = desc.add_expr,
            .set = if (desc.set) |s| @ptrCast(s) else null,
        };
        return fd.entity(self._world, val);
    }

    /// Declare & define a system.
    ///
    /// Example:
    ///
    /// @code
    /// world.define.system(Move, EcsOnUpdate, Position, Velocity);
    /// @endcode
    ///
    pub fn system(self: Define, comptime System: type, phase: ft.Entity, comptime Comps: anytype) ft.Id {
        return fd.system(self._world, System, phase, Comps);
    }

    /// Declare & define a tag.
    ///
    /// Example:
    ///
    /// @code
    /// world.define.tag(MyTag);
    /// @endcode
    pub fn tag(self: Define, comptime T: type) ft.Id {
        return fd.tag(self._world, T);
    }
};

/// Used with define.entity().
pub const EntityDesc = struct {
    /// Set to modify existing entity (optional)
    id: ft.Entity = 0,
    /// Parent entity.
    parent: ft.Entity = 0,
    /// Name of the entity. If no entity is provided, an entity with this name
    /// will be looked up first. When an entity is provided, the name will be
    /// verified with the existing entity.
    name: ?[*:0]const u8 = null,
    /// Optional custom separator for hierarchical names. Leave to NULL for
    /// default ('.') separator. Set to an empty string to prevent tokenization
    /// of name.
    sep: ?[*:0]const u8 = null,
    /// Optional, used for identifiers relative to root
    root_sep: ?[*:0]const u8 = null,
    /// Optional entity symbol. A symbol is an unscoped identifier that can be
    /// used to lookup an entity. The primary use case for this is to associate
    /// the entity with a language identifier, such as a type or function name,
    /// where these identifiers differ from the name they are registered with
    /// in flecs. For example, C type "EcsPosition" might be registered as
    /// "flecs.components.transform.Position", with the symbol set to
    /// "EcsPosition".
    symbol: ?[*:0]const u8 = null,
    /// When set to true, a low id (typically reserved for components) will be
    /// used to create the entity, if no id is specified.
    use_low_id: bool = false,
    /// 0-terminated array of ids to add to the entity.
    add: ?[*:0]const ft.Id = null,
    /// 0-terminated array of values to set on the entity.
    set: ?[*]const ValueDesc = null,
    /// String expression with components to add
    add_expr: ?[*:0]const u8 = null,
};

/// Utility to hold a value of a dynamic type.
pub const ValueDesc = extern struct {
    /// Type of value.
    type: ft.Entity = 0,
    /// Pointer to value.
    ptr: ?*anyopaque = null,
};
