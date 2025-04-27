//! Builtin component ids

const types = @import("types.zig");

/// Component component id.
pub extern const FLECS_IDEcsComponentID_: types.Entity;

/// Identifier component id.
pub extern const FLECS_IDEcsIdentifierID_: types.Entity;

/// Poly component id.
pub extern const FLECS_IDEcsPolyID_: types.Entity;

/// DefaultChildComponent component id.
pub extern const FLECS_IDEcsDefaultChildComponentID_: types.Entity;

/// Tag added to queries.
pub extern const EcsQuery: types.Entity;

/// Tag added to observers.
pub extern const EcsObserver: types.Entity;

/// Tag added to systems.
pub extern const EcsSystem: types.Entity;

/// TickSource component id.
pub extern const FLECS_IDEcsTickSourceID_: types.Entity;

/// Pipeline module component ids
pub extern const FLECS_IDEcsPipelineQueryID_: types.Entity;

/// Timer component id.
pub extern const FLECS_IDEcsTimerID_: types.Entity;

/// RateFilter component id.
pub extern const FLECS_IDEcsRateFilterID_: types.Entity;

/// Root scope for builtin flecs entities
pub extern const EcsFlecs: types.Entity;

/// Core module scope
pub extern const EcsFlecsCore: types.Entity;

/// Entity associated with world (used for "attaching" components to world)
pub extern const EcsWorld: types.Entity;

/// Wildcard entity ("*"). Matches any id, returns all matches.
pub extern const EcsWildcard: types.Entity;

/// Any entity ("_"). Matches any id, returns only the first.
pub extern const EcsAny: types.Entity;

/// This entity. Default source for queries.
pub extern const EcsThis: types.Entity;

/// Variable entity ("$"). Used in expressions to prefix variable names
pub extern const EcsVariable: types.Entity;

/// Marks a relationship as transitive.
/// Behavior:
///
/// @code
///   if R(X, Y) and R(Y, Z) then R(X, Z)
/// @endcode
///
pub extern const EcsTransitive: types.Entity;

/// Marks a relationship as reflexive.
/// Behavior:
///
/// @code
///   R(X, X) == true
/// @endcode
///
pub extern const EcsReflexive: types.Entity;

/// Ensures that entity/component cannot be used as target in `IsA` relationship.
/// Final can improve the performance of queries as they will not attempt to
/// substitute a final component with its subsets.
///
/// Behavior:
///
/// @code
///   if IsA(X, Y) and Final(Y) throw error
/// @endcode
///
pub extern const EcsFinal: types.Entity;

/// Mark component as inheritable.
/// This is the opposite of Final. This trait can be used to enforce that queries
/// take into account component inheritance before inheritance (IsA)
/// relationships are added with the component as target.
///
pub extern const EcsInheritable: types.Entity;

/// Relationship that specifies component inheritance behavior.
pub extern const EcsOnInstantiate: types.Entity;

/// Override component on instantiate.
/// This will copy the component from the base entity `(IsA target)` to the
/// instance. The base component will never be inherited from the prefab.///
pub extern const EcsOverride: types.Entity;

/// Inherit component on instantiate.
/// This will inherit (share) the component from the base entity `(IsA target)`.
/// The component can be manually overridden by adding it to the instance.///
pub extern const EcsInherit: types.Entity;

/// Never inherit component on instantiate.
/// This will not copy or share the component from the base entity `(IsA target)`.
/// When the component is added to an instance, its value will never be copied
/// from the base entity.///
pub extern const EcsDontInherit: types.Entity;

/// Marks relationship as commutative.
/// Behavior:
///
/// @code
///   if R(X, Y) then R(Y, X)
/// @endcode
///
pub extern const EcsSymmetric: types.Entity;

/// Can be added to relationship to indicate that the relationship can only occur
/// once on an entity. Adding a 2nd instance will replace the 1st.
///
/// Behavior:
///
/// @code
///   R(X, Y) + R(X, Z) = R(X, Z)
/// @endcode
///
pub extern const EcsExclusive: types.Entity;

/// Marks a relationship as acyclic. Acyclic relationships may not form cycles.
pub extern const EcsAcyclic: types.Entity;

/// Marks a relationship as traversable. Traversable relationships may be
/// traversed with "up" queries. Traversable relationships are acyclic.///
pub extern const EcsTraversable: types.Entity;

/// Ensure that a component always is added together with another component.
///
/// Behavior:
///
/// @code
///   If With(R, O) and R(X) then O(X)
///   If With(R, O) and R(X, Y) then O(X, Y)
/// @endcode
///
pub extern const EcsWith: types.Entity;

/// Ensure that relationship target is child of specified entity.
///
/// Behavior:
///
/// @code
///   If OneOf(R, O) and R(X, Y), Y must be a child of O
///   If OneOf(R) and R(X, Y), Y must be a child of R
/// @endcode
///
pub extern const EcsOneOf: types.Entity;

/// Mark a component as toggleable with ecs_enable_id().
pub extern const EcsCanToggle: types.Entity;

/// Can be added to components to indicate it is a trait. Traits are components
/// and/or tags that are added to other components to modify their behavior.
///
pub extern const EcsTrait: types.Entity;

/// Ensure that an entity is always used in pair as relationship.
///
/// Behavior:
///
/// @code
///   e.add(R) panics
///   e.add(X, R) panics, unless X has the "Trait" trait
/// @endcode
///
pub extern const EcsRelationship: types.Entity;

/// Ensure that an entity is always used in pair as target.
///
/// Behavior:
///
/// @code
///   e.add(T) panics
///   e.add(T, X) panics
/// @endcode
///
pub extern const EcsTarget: types.Entity;

/// Can be added to relationship to indicate that it should never hold data,
/// even when it or the relationship target is a component.///
pub extern const EcsPairIsTag: types.Entity;

/// Tag to indicate name identifier
pub extern const EcsName: types.Entity;

/// Tag to indicate symbol identifier
pub extern const EcsSymbol: types.Entity;

/// Tag to indicate alias identifier
pub extern const EcsAlias: types.Entity;

/// Used to express parent-child relationships.
pub extern const EcsChildOf: types.Entity;

/// Used to express inheritance relationships.
pub extern const EcsIsA: types.Entity;

/// Used to express dependency relationships
pub extern const EcsDependsOn: types.Entity;

/// Used to express a slot (used with prefab inheritance)
pub extern const EcsSlotOf: types.Entity;

/// Tag added to module entities
pub extern const EcsModule: types.Entity;

/// Tag to indicate an entity/component/system is private to a module
pub extern const EcsPrivate: types.Entity;

/// Tag added to prefab entities. Any entity with this tag is automatically
/// ignored by queries, unless #EcsPrefab is explicitly queried for.///
pub extern const EcsPrefab: types.Entity;

/// When this tag is added to an entity it is skipped by queries, unless
/// #EcsDisabled is explicitly queried for.///
pub extern const EcsDisabled: types.Entity;

/// Trait added to entities that should never be returned by queries. Reserved
/// for internal entities that have special meaning to the query engine, such as
/// #EcsThis, #EcsWildcard, #EcsAny.///
pub extern const EcsNotQueryable: types.Entity;

/// Event that triggers when an id is added to an entity
pub extern const EcsOnAdd: types.Entity;

/// Event that triggers when an id is removed from an entity
pub extern const EcsOnRemove: types.Entity;

/// Event that triggers when a component is set for an entity
pub extern const EcsOnSet: types.Entity;

/// Event that triggers observer when an entity starts/stops matching a query
pub extern const EcsMonitor: types.Entity;

/// Event that triggers when a table is created.
pub extern const EcsOnTableCreate: types.Entity;

/// Event that triggers when a table is deleted.
pub extern const EcsOnTableDelete: types.Entity;

/// Relationship used for specifying cleanup behavior.
pub extern const EcsOnDelete: types.Entity;

/// Relationship used to define what should happen when a target entity (second
/// element of a pair) is deleted.///
pub extern const EcsOnDeleteTarget: types.Entity;

/// Remove cleanup policy. Must be used as target in pair with #EcsOnDelete or
/// #EcsOnDeleteTarget.///
pub extern const EcsRemove: types.Entity;

/// Delete cleanup policy. Must be used as target in pair with #EcsOnDelete or
/// #EcsOnDeleteTarget.///
pub extern const EcsDelete: types.Entity;

/// Panic cleanup policy. Must be used as target in pair with #EcsOnDelete or
/// #EcsOnDeleteTarget.///
pub extern const EcsPanic: types.Entity;

/// Mark component as sparse
pub extern const EcsSparse: types.Entity;

/// Mark relationship as union
pub extern const EcsUnion: types.Entity;

/// Marker used to indicate `$var == ...` matching in queries.
pub extern const EcsPredEq: types.Entity;

/// Marker used to indicate `$var == "name"` matching in queries.
pub extern const EcsPredMatch: types.Entity;

/// Marker used to indicate `$var ~= "pattern"` matching in queries.
pub extern const EcsPredLookup: types.Entity;

/// Marker used to indicate the start of a scope (`{`) in queries.
pub extern const EcsScopeOpen: types.Entity;

/// Marker used to indicate the end of a scope (`}`) in queries.
pub extern const EcsScopeClose: types.Entity;

/// Tag used to indicate query is empty.
/// This tag is removed automatically when a query becomes non-empty, and is not
/// automatically re-added when it becomes empty.
///
pub extern const EcsEmpty: types.Entity;

///< Pipeline component id.
pub extern const FLECS_IDEcsPipelineID_: types.Entity;
///< OnStart pipeline phase.
pub extern const EcsOnStart: types.Entity;
///< PreFrame pipeline phase.
pub extern const EcsPreFrame: types.Entity;
///< OnLoad pipeline phase.
pub extern const EcsOnLoad: types.Entity;
///< PostLoad pipeline phase.
pub extern const EcsPostLoad: types.Entity;
///< PreUpdate pipeline phase.
pub extern const EcsPreUpdate: types.Entity;
///< OnUpdate pipeline phase.
pub extern const EcsOnUpdate: types.Entity;
///< OnValidate pipeline phase.
pub extern const EcsOnValidate: types.Entity;
///< PostUpdate pipeline phase.
pub extern const EcsPostUpdate: types.Entity;
///< PreStore pipeline phase.
pub extern const EcsPreStore: types.Entity;
///< OnStore pipeline phase.
pub extern const EcsOnStore: types.Entity;
///< PostFrame pipeline phase.
pub extern const EcsPostFrame: types.Entity;
///< Phase pipeline phase.
pub extern const EcsPhase: types.Entity;

///< Tag added to enum/bitmask constants.
pub extern const EcsConstant: types.Entity;
