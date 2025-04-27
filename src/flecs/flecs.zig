pub const FILE = opaque {};

pub const ecs_vec_t = opaque {};
pub const ecs_stack_t = opaque {};
pub const ecs_sparse_t = opaque {};
pub const ecs_map_t = opaque {};

pub const ecs_flags8_t = u8;
pub const ecs_flags16_t = u16;
pub const ecs_flags32_t = u32;
pub const ecs_flags64_t = u64;
pub const ecs_size_t = i32;

pub const ecs_float_t = f32;
pub const ecs_ftime_t = ecs_float_t;

pub const ecs_time_t = extern struct {
    sec: u32 = @import("std").mem.zeroes(u32),
    nanosec: u32 = @import("std").mem.zeroes(u32),
};

pub const ecs_os_thread_t = usize;
pub const ecs_os_cond_t = usize;
pub const ecs_os_mutex_t = usize;
pub const ecs_os_dl_t = usize;
pub const ecs_os_sock_t = usize;
pub const ecs_os_thread_id_t = u64;
pub const ecs_os_proc_t = ?*const fn () callconv(.c) void;
pub const ecs_os_api_init_t = ?*const fn () callconv(.c) void;
pub const ecs_os_api_fini_t = ?*const fn () callconv(.c) void;
pub const ecs_os_api_malloc_t = ?*const fn (ecs_size_t) callconv(.c) ?*anyopaque;
pub const ecs_os_api_free_t = ?*const fn (?*anyopaque) callconv(.c) void;
pub const ecs_os_api_realloc_t = ?*const fn (?*anyopaque, ecs_size_t) callconv(.c) ?*anyopaque;
pub const ecs_os_api_calloc_t = ?*const fn (ecs_size_t) callconv(.c) ?*anyopaque;
pub const ecs_os_api_strdup_t = ?*const fn ([*c]const u8) callconv(.c) [*c]u8;
pub const ecs_os_thread_callback_t = ?*const fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub const ecs_os_api_thread_new_t = ?*const fn (ecs_os_thread_callback_t, ?*anyopaque) callconv(.c) ecs_os_thread_t;
pub const ecs_os_api_thread_join_t = ?*const fn (ecs_os_thread_t) callconv(.c) ?*anyopaque;
pub const ecs_os_api_thread_self_t = ?*const fn () callconv(.c) ecs_os_thread_id_t;
pub const ecs_os_api_task_new_t = ?*const fn (ecs_os_thread_callback_t, ?*anyopaque) callconv(.c) ecs_os_thread_t;
pub const ecs_os_api_task_join_t = ?*const fn (ecs_os_thread_t) callconv(.c) ?*anyopaque;
pub const ecs_os_api_ainc_t = ?*const fn ([*c]i32) callconv(.c) i32;
pub const ecs_os_api_lainc_t = ?*const fn ([*c]i64) callconv(.c) i64;
pub const ecs_os_api_mutex_new_t = ?*const fn () callconv(.c) ecs_os_mutex_t;
pub const ecs_os_api_mutex_lock_t = ?*const fn (ecs_os_mutex_t) callconv(.c) void;
pub const ecs_os_api_mutex_unlock_t = ?*const fn (ecs_os_mutex_t) callconv(.c) void;
pub const ecs_os_api_mutex_free_t = ?*const fn (ecs_os_mutex_t) callconv(.c) void;
pub const ecs_os_api_cond_new_t = ?*const fn () callconv(.c) ecs_os_cond_t;
pub const ecs_os_api_cond_free_t = ?*const fn (ecs_os_cond_t) callconv(.c) void;
pub const ecs_os_api_cond_signal_t = ?*const fn (ecs_os_cond_t) callconv(.c) void;
pub const ecs_os_api_cond_broadcast_t = ?*const fn (ecs_os_cond_t) callconv(.c) void;
pub const ecs_os_api_cond_wait_t = ?*const fn (ecs_os_cond_t, ecs_os_mutex_t) callconv(.c) void;
pub const ecs_os_api_sleep_t = ?*const fn (i32, i32) callconv(.c) void;
pub const ecs_os_api_enable_high_timer_resolution_t = ?*const fn (bool) callconv(.c) void;
pub const ecs_os_api_get_time_t = ?*const fn ([*c]ecs_time_t) callconv(.c) void;
pub const ecs_os_api_now_t = ?*const fn () callconv(.c) u64;
pub const ecs_os_api_log_t = ?*const fn (i32, [*c]const u8, i32, [*c]const u8) callconv(.c) void;
pub const ecs_os_api_abort_t = ?*const fn () callconv(.c) void;
pub const ecs_os_api_dlopen_t = ?*const fn ([*c]const u8) callconv(.c) ecs_os_dl_t;
pub const ecs_os_api_dlproc_t = ?*const fn (ecs_os_dl_t, [*c]const u8) callconv(.c) ecs_os_proc_t;
pub const ecs_os_api_dlclose_t = ?*const fn (ecs_os_dl_t) callconv(.c) void;
pub const ecs_os_api_module_to_path_t = ?*const fn ([*c]const u8) callconv(.c) [*c]u8;
pub const ecs_os_api_perf_trace_t = ?*const fn ([*c]const u8, usize, [*c]const u8) callconv(.c) void;

pub const ecs_os_api_t = extern struct {
    init_: ecs_os_api_init_t = @import("std").mem.zeroes(ecs_os_api_init_t),
    fini_: ecs_os_api_fini_t = @import("std").mem.zeroes(ecs_os_api_fini_t),
    malloc_: ecs_os_api_malloc_t = @import("std").mem.zeroes(ecs_os_api_malloc_t),
    realloc_: ecs_os_api_realloc_t = @import("std").mem.zeroes(ecs_os_api_realloc_t),
    calloc_: ecs_os_api_calloc_t = @import("std").mem.zeroes(ecs_os_api_calloc_t),
    free_: ecs_os_api_free_t = @import("std").mem.zeroes(ecs_os_api_free_t),
    strdup_: ecs_os_api_strdup_t = @import("std").mem.zeroes(ecs_os_api_strdup_t),
    thread_new_: ecs_os_api_thread_new_t = @import("std").mem.zeroes(ecs_os_api_thread_new_t),
    thread_join_: ecs_os_api_thread_join_t = @import("std").mem.zeroes(ecs_os_api_thread_join_t),
    thread_self_: ecs_os_api_thread_self_t = @import("std").mem.zeroes(ecs_os_api_thread_self_t),
    task_new_: ecs_os_api_thread_new_t = @import("std").mem.zeroes(ecs_os_api_thread_new_t),
    task_join_: ecs_os_api_thread_join_t = @import("std").mem.zeroes(ecs_os_api_thread_join_t),
    ainc_: ecs_os_api_ainc_t = @import("std").mem.zeroes(ecs_os_api_ainc_t),
    adec_: ecs_os_api_ainc_t = @import("std").mem.zeroes(ecs_os_api_ainc_t),
    lainc_: ecs_os_api_lainc_t = @import("std").mem.zeroes(ecs_os_api_lainc_t),
    ladec_: ecs_os_api_lainc_t = @import("std").mem.zeroes(ecs_os_api_lainc_t),
    mutex_new_: ecs_os_api_mutex_new_t = @import("std").mem.zeroes(ecs_os_api_mutex_new_t),
    mutex_free_: ecs_os_api_mutex_free_t = @import("std").mem.zeroes(ecs_os_api_mutex_free_t),
    mutex_lock_: ecs_os_api_mutex_lock_t = @import("std").mem.zeroes(ecs_os_api_mutex_lock_t),
    mutex_unlock_: ecs_os_api_mutex_lock_t = @import("std").mem.zeroes(ecs_os_api_mutex_lock_t),
    cond_new_: ecs_os_api_cond_new_t = @import("std").mem.zeroes(ecs_os_api_cond_new_t),
    cond_free_: ecs_os_api_cond_free_t = @import("std").mem.zeroes(ecs_os_api_cond_free_t),
    cond_signal_: ecs_os_api_cond_signal_t = @import("std").mem.zeroes(ecs_os_api_cond_signal_t),
    cond_broadcast_: ecs_os_api_cond_broadcast_t = @import("std").mem.zeroes(ecs_os_api_cond_broadcast_t),
    cond_wait_: ecs_os_api_cond_wait_t = @import("std").mem.zeroes(ecs_os_api_cond_wait_t),
    sleep_: ecs_os_api_sleep_t = @import("std").mem.zeroes(ecs_os_api_sleep_t),
    now_: ecs_os_api_now_t = @import("std").mem.zeroes(ecs_os_api_now_t),
    get_time_: ecs_os_api_get_time_t = @import("std").mem.zeroes(ecs_os_api_get_time_t),
    log_: ecs_os_api_log_t = @import("std").mem.zeroes(ecs_os_api_log_t),
    abort_: ecs_os_api_abort_t = @import("std").mem.zeroes(ecs_os_api_abort_t),
    dlopen_: ecs_os_api_dlopen_t = @import("std").mem.zeroes(ecs_os_api_dlopen_t),
    dlproc_: ecs_os_api_dlproc_t = @import("std").mem.zeroes(ecs_os_api_dlproc_t),
    dlclose_: ecs_os_api_dlclose_t = @import("std").mem.zeroes(ecs_os_api_dlclose_t),
    module_to_dl_: ecs_os_api_module_to_path_t = @import("std").mem.zeroes(ecs_os_api_module_to_path_t),
    module_to_etc_: ecs_os_api_module_to_path_t = @import("std").mem.zeroes(ecs_os_api_module_to_path_t),
    perf_trace_push_: ecs_os_api_perf_trace_t = @import("std").mem.zeroes(ecs_os_api_perf_trace_t),
    perf_trace_pop_: ecs_os_api_perf_trace_t = @import("std").mem.zeroes(ecs_os_api_perf_trace_t),
    log_level_: i32 = @import("std").mem.zeroes(i32),
    log_indent_: i32 = @import("std").mem.zeroes(i32),
    log_last_error_: i32 = @import("std").mem.zeroes(i32),
    log_last_timestamp_: i64 = @import("std").mem.zeroes(i64),
    flags_: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    log_out_: ?*FILE = null,
};
pub extern var ecs_os_api: ecs_os_api_t;

pub extern fn ecs_os_init() void;
pub extern fn ecs_os_fini() void;
pub extern fn ecs_os_set_api(os_api: [*c]ecs_os_api_t) void;
pub extern fn ecs_os_get_api() ecs_os_api_t;
pub extern fn ecs_os_set_api_defaults() void;

pub const ecs_id_t = u64;
pub const ecs_entity_t = ecs_id_t;
pub const ecs_type_t = extern struct {
    array: [*c]ecs_id_t = @import("std").mem.zeroes([*c]ecs_id_t),
    count: i32 = @import("std").mem.zeroes(i32),
};

pub const ecs_world_t = opaque {};
pub const ecs_stage_t = opaque {};
pub const ecs_table_t = opaque {};

pub const ecs_term_ref_t = extern struct {
    id: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};

pub const ecs_term_t = extern struct {
    id: ecs_id_t = @import("std").mem.zeroes(ecs_id_t),
    src: ecs_term_ref_t = @import("std").mem.zeroes(ecs_term_ref_t),
    first: ecs_term_ref_t = @import("std").mem.zeroes(ecs_term_ref_t),
    second: ecs_term_ref_t = @import("std").mem.zeroes(ecs_term_ref_t),
    trav: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    inout: i16 = @import("std").mem.zeroes(i16),
    oper: i16 = @import("std").mem.zeroes(i16),
    field_index: i8 = @import("std").mem.zeroes(i8),
    flags_: ecs_flags16_t = @import("std").mem.zeroes(ecs_flags16_t),
};

pub const ecs_mixins_t = opaque {};

pub const ecs_header_t = extern struct {
    magic: i32 = @import("std").mem.zeroes(i32),
    type: i32 = @import("std").mem.zeroes(i32),
    refcount: i32 = @import("std").mem.zeroes(i32),
    mixins: ?*ecs_mixins_t = @import("std").mem.zeroes(?*ecs_mixins_t),
};

pub const EcsQueryCacheDefault: c_int = 0;
pub const EcsQueryCacheAuto: c_int = 1;
pub const EcsQueryCacheAll: c_int = 2;
pub const EcsQueryCacheNone: c_int = 3;
pub const ecs_query_cache_kind_t = c_uint;

pub const ecs_query_t = extern struct {
    hdr: ecs_header_t = @import("std").mem.zeroes(ecs_header_t),
    terms: [32]ecs_term_t = @import("std").mem.zeroes([32]ecs_term_t),
    sizes: [32]i32 = @import("std").mem.zeroes([32]i32),
    ids: [32]ecs_id_t = @import("std").mem.zeroes([32]ecs_id_t),
    flags: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    var_count: i8 = @import("std").mem.zeroes(i8),
    term_count: i8 = @import("std").mem.zeroes(i8),
    field_count: i8 = @import("std").mem.zeroes(i8),
    fixed_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    var_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    static_id_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    data_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    write_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    read_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    row_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    shared_readonly_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    set_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    cache_kind: ecs_query_cache_kind_t = @import("std").mem.zeroes(ecs_query_cache_kind_t),
    vars: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    binding_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    real_world: ?*ecs_world_t = @import("std").mem.zeroes(?*ecs_world_t),
    world: ?*ecs_world_t = @import("std").mem.zeroes(?*ecs_world_t),
    eval_count: i32 = @import("std").mem.zeroes(i32),
};

pub const ecs_table_range_t = extern struct {
    table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    offset: i32 = @import("std").mem.zeroes(i32),
    count: i32 = @import("std").mem.zeroes(i32),
};

pub const ecs_var_t = extern struct {
    range: ecs_table_range_t = @import("std").mem.zeroes(ecs_table_range_t),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
};

pub const ecs_table_cache_t_4 = opaque {};

pub const ecs_table_cache_hdr_t = extern struct {
    cache: ?*ecs_table_cache_t_4 = @import("std").mem.zeroes(?*ecs_table_cache_t_4),
    table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    prev: [*c]ecs_table_cache_hdr_t = @import("std").mem.zeroes([*c]ecs_table_cache_hdr_t),
    next: [*c]ecs_table_cache_hdr_t = @import("std").mem.zeroes([*c]ecs_table_cache_hdr_t),
};

pub const ecs_table_record_t = extern struct {
    hdr: ecs_table_cache_hdr_t = @import("std").mem.zeroes(ecs_table_cache_hdr_t),
    index: i16 = @import("std").mem.zeroes(i16),
    count: i16 = @import("std").mem.zeroes(i16),
    column: i16 = @import("std").mem.zeroes(i16),
};

pub const struct_ecs_query_var_t_6 = opaque {};
pub const struct_ecs_query_op_t_7 = opaque {};
pub const struct_ecs_query_op_ctx_t_8 = opaque {};
pub const ecs_query_cache_table_match_t = opaque {};

pub const ecs_query_op_profile_t = extern struct {
    count: [2]i32 = @import("std").mem.zeroes([2]i32),
};

pub const ecs_query_iter_t = extern struct {
    query: [*c]const ecs_query_t = @import("std").mem.zeroes([*c]const ecs_query_t),
    vars: [*c]ecs_var_t = @import("std").mem.zeroes([*c]ecs_var_t),
    query_vars: ?*const struct_ecs_query_var_t_6 = @import("std").mem.zeroes(?*const struct_ecs_query_var_t_6),
    ops: ?*const struct_ecs_query_op_t_7 = @import("std").mem.zeroes(?*const struct_ecs_query_op_t_7),
    op_ctx: ?*struct_ecs_query_op_ctx_t_8 = @import("std").mem.zeroes(?*struct_ecs_query_op_ctx_t_8),
    node: ?*ecs_query_cache_table_match_t = @import("std").mem.zeroes(?*ecs_query_cache_table_match_t),
    prev: ?*ecs_query_cache_table_match_t = @import("std").mem.zeroes(?*ecs_query_cache_table_match_t),
    last: ?*ecs_query_cache_table_match_t = @import("std").mem.zeroes(?*ecs_query_cache_table_match_t),
    written: [*c]u64 = @import("std").mem.zeroes([*c]u64),
    skip_count: i32 = @import("std").mem.zeroes(i32),
    profile: [*c]ecs_query_op_profile_t = @import("std").mem.zeroes([*c]ecs_query_op_profile_t),
    op: i16 = @import("std").mem.zeroes(i16),
    sp: i16 = @import("std").mem.zeroes(i16),
};

pub const ecs_page_iter_t = extern struct {
    offset: i32 = @import("std").mem.zeroes(i32),
    limit: i32 = @import("std").mem.zeroes(i32),
    remaining: i32 = @import("std").mem.zeroes(i32),
};

pub const ecs_worker_iter_t = extern struct {
    index: i32 = @import("std").mem.zeroes(i32),
    count: i32 = @import("std").mem.zeroes(i32),
};

pub const ecs_table_cache_iter_t = extern struct {
    cur: [*c]const ecs_table_cache_hdr_t = @import("std").mem.zeroes([*c]const ecs_table_cache_hdr_t),
    next: [*c]const ecs_table_cache_hdr_t = @import("std").mem.zeroes([*c]const ecs_table_cache_hdr_t),
    iter_fill: bool = @import("std").mem.zeroes(bool),
    iter_empty: bool = @import("std").mem.zeroes(bool),
};

pub const ecs_each_iter_t = extern struct {
    it: ecs_table_cache_iter_t = @import("std").mem.zeroes(ecs_table_cache_iter_t),
    ids: ecs_id_t = @import("std").mem.zeroes(ecs_id_t),
    sources: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    sizes: ecs_size_t = @import("std").mem.zeroes(ecs_size_t),
    columns: i32 = @import("std").mem.zeroes(i32),
    trs: [*c]const ecs_table_record_t = @import("std").mem.zeroes([*c]const ecs_table_record_t),
};

const union_unnamed_5 = extern union {
    query: ecs_query_iter_t,
    page: ecs_page_iter_t,
    worker: ecs_worker_iter_t,
    each: ecs_each_iter_t,
};

pub const ecs_stack_page_t = extern struct {
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    next: [*c]ecs_stack_page_t = @import("std").mem.zeroes([*c]ecs_stack_page_t),
    sp: i16 = @import("std").mem.zeroes(i16),
    id: u32 = @import("std").mem.zeroes(u32),
};

pub const ecs_stack_cursor_t = extern struct {
    prev: [*c]ecs_stack_cursor_t = @import("std").mem.zeroes([*c]ecs_stack_cursor_t),
    page: [*c]ecs_stack_page_t = @import("std").mem.zeroes([*c]ecs_stack_page_t),
    sp: i16 = @import("std").mem.zeroes(i16),
    is_free: bool = @import("std").mem.zeroes(bool),
    owner: ?*ecs_stack_t = null,
};

pub const ecs_iter_cache_t = extern struct {
    stack_cursor: [*c]ecs_stack_cursor_t = @import("std").mem.zeroes([*c]ecs_stack_cursor_t),
    used: ecs_flags8_t = @import("std").mem.zeroes(ecs_flags8_t),
    allocated: ecs_flags8_t = @import("std").mem.zeroes(ecs_flags8_t),
};

pub const ecs_iter_private_t = extern struct {
    iter: union_unnamed_5 = @import("std").mem.zeroes(union_unnamed_5),
    entity_iter: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    cache: ecs_iter_cache_t = @import("std").mem.zeroes(ecs_iter_cache_t),
};

pub const ecs_iter_next_action_t = ?*const fn ([*c]ecs_iter_t) callconv(.c) bool;
pub const ecs_iter_fini_action_t = ?*const fn ([*c]ecs_iter_t) callconv(.c) void;

pub const ecs_iter_t = extern struct {
    world: ?*ecs_world_t = @import("std").mem.zeroes(?*ecs_world_t),
    real_world: ?*ecs_world_t = @import("std").mem.zeroes(?*ecs_world_t),
    entities: [*c]const ecs_entity_t = @import("std").mem.zeroes([*c]const ecs_entity_t),
    sizes: [*c]const ecs_size_t = @import("std").mem.zeroes([*c]const ecs_size_t),
    table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    other_table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    ids: [*c]ecs_id_t = @import("std").mem.zeroes([*c]ecs_id_t),
    variables: [*c]ecs_var_t = @import("std").mem.zeroes([*c]ecs_var_t),
    trs: [*c][*c]const ecs_table_record_t = @import("std").mem.zeroes([*c][*c]const ecs_table_record_t),
    sources: [*c]ecs_entity_t = @import("std").mem.zeroes([*c]ecs_entity_t),
    constrained_vars: ecs_flags64_t = @import("std").mem.zeroes(ecs_flags64_t),
    group_id: u64 = @import("std").mem.zeroes(u64),
    set_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    ref_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    row_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    up_fields: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    system: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    event: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    event_id: ecs_id_t = @import("std").mem.zeroes(ecs_id_t),
    event_cur: i32 = @import("std").mem.zeroes(i32),
    field_count: i8 = @import("std").mem.zeroes(i8),
    term_index: i8 = @import("std").mem.zeroes(i8),
    variable_count: i8 = @import("std").mem.zeroes(i8),
    query: [*c]const ecs_query_t = @import("std").mem.zeroes([*c]const ecs_query_t),
    variable_names: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    param: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    binding_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    callback_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    run_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    delta_time: f32 = @import("std").mem.zeroes(f32),
    delta_system_time: f32 = @import("std").mem.zeroes(f32),
    frame_offset: i32 = @import("std").mem.zeroes(i32),
    offset: i32 = @import("std").mem.zeroes(i32),
    count: i32 = @import("std").mem.zeroes(i32),
    flags: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    interrupted_by: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    priv_: ecs_iter_private_t = @import("std").mem.zeroes(ecs_iter_private_t),
    next: ecs_iter_next_action_t = @import("std").mem.zeroes(ecs_iter_next_action_t),
    callback: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    fini: ecs_iter_fini_action_t = @import("std").mem.zeroes(ecs_iter_fini_action_t),
    chain_it: [*c]ecs_iter_t = @import("std").mem.zeroes([*c]ecs_iter_t),
};

pub const ecs_iter_action_t = ?*const fn (*anyopaque) callconv(.c) void;
pub const ecs_run_action_t = ?*const fn (?*anyopaque) callconv(.c) void;
pub const ecs_ctx_free_t = ?*const fn (?*anyopaque) callconv(.c) void;

pub const struct_ecs_event_id_record_t_9 = opaque {};
pub const ecs_event_record_t = extern struct {
    any: ?*struct_ecs_event_id_record_t_9 = @import("std").mem.zeroes(?*struct_ecs_event_id_record_t_9),
    wildcard: ?*struct_ecs_event_id_record_t_9 = @import("std").mem.zeroes(?*struct_ecs_event_id_record_t_9),
    wildcard_pair: ?*struct_ecs_event_id_record_t_9 = @import("std").mem.zeroes(?*struct_ecs_event_id_record_t_9),
    event_ids: ecs_map_t = @import("std").mem.zeroes(ecs_map_t),
    event: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
};

pub const ecs_observable_t = extern struct {
    on_add: ecs_event_record_t = @import("std").mem.zeroes(ecs_event_record_t),
    on_remove: ecs_event_record_t = @import("std").mem.zeroes(ecs_event_record_t),
    on_set: ecs_event_record_t = @import("std").mem.zeroes(ecs_event_record_t),
    on_wildcard: ecs_event_record_t = @import("std").mem.zeroes(ecs_event_record_t),
    events: ecs_sparse_t = @import("std").mem.zeroes(ecs_sparse_t),
    last_observer_id: u64 = @import("std").mem.zeroes(u64),
};

pub const ecs_observer_t = extern struct {
    hdr: ecs_header_t = @import("std").mem.zeroes(ecs_header_t),
    query: [*c]ecs_query_t = @import("std").mem.zeroes([*c]ecs_query_t),
    events: [8]ecs_entity_t = @import("std").mem.zeroes([8]ecs_entity_t),
    event_count: i32 = @import("std").mem.zeroes(i32),
    callback: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    run: ecs_run_action_t = @import("std").mem.zeroes(ecs_run_action_t),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    callback_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    run_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    callback_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    run_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    observable: ?*ecs_observable_t = @import("std").mem.zeroes(?*ecs_observable_t),
    world: ?*ecs_world_t = @import("std").mem.zeroes(?*ecs_world_t),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
};

pub const ecs_component_record_t = opaque {};

pub const ecs_record_t = extern struct {
    cdr: ?*ecs_component_record_t = @import("std").mem.zeroes(?*ecs_component_record_t),
    table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    row: u32 = @import("std").mem.zeroes(u32),
    dense: i32 = @import("std").mem.zeroes(i32),
};

pub const ecs_ref_t = extern struct {
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    id: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    table_id: u64 = @import("std").mem.zeroes(u64),
    table_version: u32 = @import("std").mem.zeroes(u32),
    record: [*c]ecs_record_t = @import("std").mem.zeroes([*c]ecs_record_t),
    ptr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};

pub const ecs_type_hooks_t = extern struct {
    ctor: ecs_xtor_t = @import("std").mem.zeroes(ecs_xtor_t),
    dtor: ecs_xtor_t = @import("std").mem.zeroes(ecs_xtor_t),
    copy: ecs_copy_t = @import("std").mem.zeroes(ecs_copy_t),
    move: ecs_move_t = @import("std").mem.zeroes(ecs_move_t),
    copy_ctor: ecs_copy_t = @import("std").mem.zeroes(ecs_copy_t),
    move_ctor: ecs_move_t = @import("std").mem.zeroes(ecs_move_t),
    ctor_move_dtor: ecs_move_t = @import("std").mem.zeroes(ecs_move_t),
    move_dtor: ecs_move_t = @import("std").mem.zeroes(ecs_move_t),
    cmp: ecs_cmp_t = @import("std").mem.zeroes(ecs_cmp_t),
    equals: ecs_equals_t = @import("std").mem.zeroes(ecs_equals_t),
    flags: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    on_add: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    on_set: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    on_remove: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    binding_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    lifecycle_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    binding_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    lifecycle_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
};

pub const ecs_type_info_t = extern struct {
    size: ecs_size_t = @import("std").mem.zeroes(ecs_size_t),
    alignment: ecs_size_t = @import("std").mem.zeroes(ecs_size_t),
    hooks: ecs_type_hooks_t = @import("std").mem.zeroes(ecs_type_hooks_t),
    component: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};

pub const ecs_xtor_t = ?*const fn (?*anyopaque, i32, [*c]const ecs_type_info_t) callconv(.c) void;
pub const ecs_copy_t = ?*const fn (?*anyopaque, ?*const anyopaque, i32, [*c]const ecs_type_info_t) callconv(.c) void;
pub const ecs_move_t = ?*const fn (?*anyopaque, ?*anyopaque, i32, [*c]const ecs_type_info_t) callconv(.c) void;
pub const ecs_cmp_t = ?*const fn (?*const anyopaque, ?*const anyopaque, [*c]const ecs_type_info_t) callconv(.c) c_int;
pub const ecs_equals_t = ?*const fn (?*const anyopaque, ?*const anyopaque, [*c]const ecs_type_info_t) callconv(.c) bool;

pub const ecs_poly_t = anyopaque;
pub const ecs_order_by_action_t = ?*const fn (ecs_entity_t, ?*const anyopaque, ecs_entity_t, ?*const anyopaque) callconv(.c) c_int;
pub const ecs_sort_table_action_t = ?*const fn (?*ecs_world_t, ?*ecs_table_t, [*c]ecs_entity_t, ?*anyopaque, i32, i32, i32, ecs_order_by_action_t) callconv(.c) void;
pub const ecs_group_by_action_t = ?*const fn (?*ecs_world_t, ?*ecs_table_t, ecs_id_t, ?*anyopaque) callconv(.c) u64;
pub const ecs_group_create_action_t = ?*const fn (?*ecs_world_t, u64, ?*anyopaque) callconv(.c) ?*anyopaque;
pub const ecs_group_delete_action_t = ?*const fn (?*ecs_world_t, u64, ?*anyopaque, ?*anyopaque) callconv(.c) void;
pub const ecs_module_action_t = ?*const fn (?*ecs_world_t) callconv(.c) void;
pub const ecs_fini_action_t = ?*const fn (?*ecs_world_t, ?*anyopaque) callconv(.c) void;
pub const ecs_compare_action_t = ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int;
pub const ecs_hash_value_action_t = ?*const fn (?*const anyopaque) callconv(.c) u64;

pub const EcsInOutDefault: c_int = 0;
pub const EcsInOutNone: c_int = 1;
pub const EcsInOutFilter: c_int = 2;
pub const EcsInOut: c_int = 3;
pub const EcsIn: c_int = 4;
pub const EcsOut: c_int = 5;
pub const EcsAnd: c_int = 0;
pub const EcsOr: c_int = 1;
pub const EcsNot: c_int = 2;
pub const EcsOptional: c_int = 3;
pub const EcsAndFrom: c_int = 4;
pub const EcsOrFrom: c_int = 5;
pub const EcsNotFrom: c_int = 6;

pub const ecs_inout_kind_t = c_uint;
pub const ecs_oper_kind_t = c_uint;

pub const ecs_data_t = opaque {};

pub const ecs_commands_t = extern struct {
    queue: ecs_vec_t = @import("std").mem.zeroes(ecs_vec_t),
    stack: ecs_stack_t = @import("std").mem.zeroes(ecs_stack_t),
    entries: ecs_sparse_t = @import("std").mem.zeroes(ecs_sparse_t),
};

pub extern fn ecs_record_find(world: ?*const ecs_world_t, entity: ecs_entity_t) [*c]ecs_record_t;
pub extern fn ecs_record_get_entity(record: [*c]const ecs_record_t) ecs_entity_t;
pub extern fn ecs_write_begin(world: ?*ecs_world_t, entity: ecs_entity_t) [*c]ecs_record_t;
pub extern fn ecs_write_end(record: [*c]ecs_record_t) void;
pub extern fn ecs_read_begin(world: ?*ecs_world_t, entity: ecs_entity_t) [*c]const ecs_record_t;
pub extern fn ecs_read_end(record: [*c]const ecs_record_t) void;
pub extern fn ecs_record_get_id(world: ?*const ecs_world_t, record: [*c]const ecs_record_t, id: ecs_id_t) ?*const anyopaque;
pub extern fn ecs_record_ensure_id(world: ?*ecs_world_t, record: [*c]ecs_record_t, id: ecs_id_t) ?*anyopaque;
pub extern fn ecs_record_has_id(world: ?*ecs_world_t, record: [*c]const ecs_record_t, id: ecs_id_t) bool;
pub extern fn ecs_record_get_by_column(record: [*c]const ecs_record_t, column: i32, size: usize) ?*anyopaque;

pub const ecs_table_records_t = extern struct {
    array: [*c]const ecs_table_record_t = @import("std").mem.zeroes([*c]const ecs_table_record_t),
    count: i32 = @import("std").mem.zeroes(i32),
};

pub extern fn flecs_table_records(table: ?*ecs_table_t) ecs_table_records_t;

pub const ecs_value_t = extern struct {
    type: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    ptr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};

pub const ecs_entity_desc_t = extern struct {
    _canary: i32 = @import("std").mem.zeroes(i32),
    id: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    parent: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    name: ?[*]const u8 = null,
    sep: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    root_sep: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    symbol: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    use_low_id: bool = @import("std").mem.zeroes(bool),
    add: ?[*]const ecs_id_t = null,
    set: [*c]const ecs_value_t = @import("std").mem.zeroes([*c]const ecs_value_t),
    add_expr: ?[*]const u8 = null,
};

pub const ecs_bulk_desc_t = extern struct {
    _canary: i32 = @import("std").mem.zeroes(i32),
    entities: [*c]ecs_entity_t = @import("std").mem.zeroes([*c]ecs_entity_t),
    count: i32 = @import("std").mem.zeroes(i32),
    ids: [32]ecs_id_t = @import("std").mem.zeroes([32]ecs_id_t),
    data: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
};

pub const ecs_component_desc_t = extern struct {
    _canary: i32 = @import("std").mem.zeroes(i32),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    type: ecs_type_info_t = @import("std").mem.zeroes(ecs_type_info_t),
};

pub const ecs_query_desc_t = extern struct {
    _canary: i32 = @import("std").mem.zeroes(i32),
    terms: [32]ecs_term_t = @import("std").mem.zeroes([32]ecs_term_t),
    expr: ?[*]const u8 = null,
    cache_kind: ecs_query_cache_kind_t = @import("std").mem.zeroes(ecs_query_cache_kind_t),
    flags: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
    order_by_callback: ecs_order_by_action_t = @import("std").mem.zeroes(ecs_order_by_action_t),
    order_by_table_callback: ecs_sort_table_action_t = @import("std").mem.zeroes(ecs_sort_table_action_t),
    order_by: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    group_by: ecs_id_t = @import("std").mem.zeroes(ecs_id_t),
    group_by_callback: ecs_group_by_action_t = @import("std").mem.zeroes(ecs_group_by_action_t),
    on_group_create: ecs_group_create_action_t = @import("std").mem.zeroes(ecs_group_create_action_t),
    on_group_delete: ecs_group_delete_action_t = @import("std").mem.zeroes(ecs_group_delete_action_t),
    group_by_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    group_by_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    binding_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    binding_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
};

pub const ecs_observer_desc_t = extern struct {
    _canary: i32 = @import("std").mem.zeroes(i32),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    query: ecs_query_desc_t = @import("std").mem.zeroes(ecs_query_desc_t),
    events: [8]ecs_entity_t = @import("std").mem.zeroes([8]ecs_entity_t),
    yield_existing: bool = @import("std").mem.zeroes(bool),
    callback: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    run: ecs_run_action_t = @import("std").mem.zeroes(ecs_run_action_t),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    callback_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    callback_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    run_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    run_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    observable: ?*ecs_poly_t = @import("std").mem.zeroes(?*ecs_poly_t),
    last_event_id: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    term_index_: i8 = @import("std").mem.zeroes(i8),
    flags_: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
};

pub const ecs_event_desc_t = extern struct {
    event: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    ids: [*c]const ecs_type_t = @import("std").mem.zeroes([*c]const ecs_type_t),
    table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    other_table: ?*ecs_table_t = @import("std").mem.zeroes(?*ecs_table_t),
    offset: i32 = @import("std").mem.zeroes(i32),
    count: i32 = @import("std").mem.zeroes(i32),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    param: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    const_param: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
    observable: ?*ecs_poly_t = @import("std").mem.zeroes(?*ecs_poly_t),
    flags: ecs_flags32_t = @import("std").mem.zeroes(ecs_flags32_t),
};

pub const ecs_build_info_t = extern struct {
    compiler: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    addons: [*c][*c]const u8 = @import("std").mem.zeroes([*c][*c]const u8),
    version: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    version_major: i16 = @import("std").mem.zeroes(i16),
    version_minor: i16 = @import("std").mem.zeroes(i16),
    version_patch: i16 = @import("std").mem.zeroes(i16),
    debug: bool = @import("std").mem.zeroes(bool),
    sanitize: bool = @import("std").mem.zeroes(bool),
    perf_trace: bool = @import("std").mem.zeroes(bool),
};

const struct_unnamed_10 = extern struct {
    add_count: i64 = @import("std").mem.zeroes(i64),
    remove_count: i64 = @import("std").mem.zeroes(i64),
    delete_count: i64 = @import("std").mem.zeroes(i64),
    clear_count: i64 = @import("std").mem.zeroes(i64),
    set_count: i64 = @import("std").mem.zeroes(i64),
    ensure_count: i64 = @import("std").mem.zeroes(i64),
    modified_count: i64 = @import("std").mem.zeroes(i64),
    discard_count: i64 = @import("std").mem.zeroes(i64),
    event_count: i64 = @import("std").mem.zeroes(i64),
    other_count: i64 = @import("std").mem.zeroes(i64),
    batched_entity_count: i64 = @import("std").mem.zeroes(i64),
    batched_command_count: i64 = @import("std").mem.zeroes(i64),
};

pub const ecs_world_info_t = extern struct {
    last_component_id: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    min_id: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    max_id: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    delta_time_raw: f32 = @import("std").mem.zeroes(f32),
    delta_time: f32 = @import("std").mem.zeroes(f32),
    time_scale: f32 = @import("std").mem.zeroes(f32),
    target_fps: f32 = @import("std").mem.zeroes(f32),
    frame_time_total: f32 = @import("std").mem.zeroes(f32),
    system_time_total: f32 = @import("std").mem.zeroes(f32),
    emit_time_total: f32 = @import("std").mem.zeroes(f32),
    merge_time_total: f32 = @import("std").mem.zeroes(f32),
    rematch_time_total: f32 = @import("std").mem.zeroes(f32),
    world_time_total: f64 = @import("std").mem.zeroes(f64),
    world_time_total_raw: f64 = @import("std").mem.zeroes(f64),
    frame_count_total: i64 = @import("std").mem.zeroes(i64),
    merge_count_total: i64 = @import("std").mem.zeroes(i64),
    eval_comp_monitors_total: i64 = @import("std").mem.zeroes(i64),
    rematch_count_total: i64 = @import("std").mem.zeroes(i64),
    id_create_total: i64 = @import("std").mem.zeroes(i64),
    id_delete_total: i64 = @import("std").mem.zeroes(i64),
    table_create_total: i64 = @import("std").mem.zeroes(i64),
    table_delete_total: i64 = @import("std").mem.zeroes(i64),
    pipeline_build_count_total: i64 = @import("std").mem.zeroes(i64),
    systems_ran_frame: i64 = @import("std").mem.zeroes(i64),
    observers_ran_frame: i64 = @import("std").mem.zeroes(i64),
    tag_id_count: i32 = @import("std").mem.zeroes(i32),
    component_id_count: i32 = @import("std").mem.zeroes(i32),
    pair_id_count: i32 = @import("std").mem.zeroes(i32),
    table_count: i32 = @import("std").mem.zeroes(i32),
    cmd: struct_unnamed_10 = @import("std").mem.zeroes(struct_unnamed_10),
    name_prefix: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};

pub extern const ECS_PAIR: ecs_id_t;
pub extern const ECS_AUTO_OVERRIDE: ecs_id_t;
pub extern const ECS_TOGGLE: ecs_id_t;

pub extern const EcsObserver: ecs_entity_t;
pub extern const EcsSystem: ecs_entity_t;
pub extern const EcsWorld: ecs_entity_t;
pub extern const EcsWildcard: ecs_entity_t;
pub extern const EcsAny: ecs_entity_t;
pub extern const EcsThis: ecs_entity_t;
pub extern const EcsVariable: ecs_entity_t;
pub extern const EcsTransitive: ecs_entity_t;
pub extern const EcsReflexive: ecs_entity_t;
pub extern const EcsFinal: ecs_entity_t;
pub extern const EcsInheritable: ecs_entity_t;
pub extern const EcsOnInstantiate: ecs_entity_t;
pub extern const EcsOverride: ecs_entity_t;
pub extern const EcsInherit: ecs_entity_t;
pub extern const EcsDontInherit: ecs_entity_t;
pub extern const EcsSymmetric: ecs_entity_t;
pub extern const EcsExclusive: ecs_entity_t;
pub extern const EcsAcyclic: ecs_entity_t;
pub extern const EcsTraversable: ecs_entity_t;
pub extern const EcsWith: ecs_entity_t;
pub extern const EcsOneOf: ecs_entity_t;
pub extern const EcsCanToggle: ecs_entity_t;
pub extern const EcsTrait: ecs_entity_t;
pub extern const EcsRelationship: ecs_entity_t;
pub extern const EcsTarget: ecs_entity_t;
pub extern const EcsPairIsTag: ecs_entity_t;
pub extern const EcsName: ecs_entity_t;
pub extern const EcsSymbol: ecs_entity_t;
pub extern const EcsAlias: ecs_entity_t;
pub extern const EcsChildOf: ecs_entity_t;
pub extern const EcsIsA: ecs_entity_t;
pub extern const EcsDependsOn: ecs_entity_t;
pub extern const EcsSlotOf: ecs_entity_t;
pub extern const EcsModule: ecs_entity_t;
pub extern const EcsPrivate: ecs_entity_t;
pub extern const EcsPrefab: ecs_entity_t;
pub extern const EcsDisabled: ecs_entity_t;
pub extern const EcsNotQueryable: ecs_entity_t;
pub extern const EcsOnAdd: ecs_entity_t;
pub extern const EcsOnRemove: ecs_entity_t;
pub extern const EcsOnSet: ecs_entity_t;
pub extern const EcsMonitor: ecs_entity_t;
pub extern const EcsOnTableCreate: ecs_entity_t;
pub extern const EcsOnTableDelete: ecs_entity_t;
pub extern const EcsOnDelete: ecs_entity_t;
pub extern const EcsOnDeleteTarget: ecs_entity_t;
pub extern const EcsRemove: ecs_entity_t;
pub extern const EcsDelete: ecs_entity_t;
pub extern const EcsPanic: ecs_entity_t;
pub extern const EcsSparse: ecs_entity_t;
pub extern const EcsUnion: ecs_entity_t;
pub extern const EcsPredEq: ecs_entity_t;
pub extern const EcsPredMatch: ecs_entity_t;
pub extern const EcsPredLookup: ecs_entity_t;
pub extern const EcsScopeOpen: ecs_entity_t;
pub extern const EcsScopeClose: ecs_entity_t;
pub extern const EcsEmpty: ecs_entity_t;
pub extern const EcsOnStart: ecs_entity_t;
pub extern const EcsPreFrame: ecs_entity_t;
pub extern const EcsOnLoad: ecs_entity_t;
pub extern const EcsPostLoad: ecs_entity_t;
pub extern const EcsPreUpdate: ecs_entity_t;
pub extern const EcsOnUpdate: ecs_entity_t;
pub extern const EcsOnValidate: ecs_entity_t;
pub extern const EcsPostUpdate: ecs_entity_t;
pub extern const EcsPreStore: ecs_entity_t;
pub extern const EcsOnStore: ecs_entity_t;
pub extern const EcsPostFrame: ecs_entity_t;
pub extern const EcsPhase: ecs_entity_t;
pub extern const EcsConstant: ecs_entity_t;

pub extern fn ecs_init() ?*ecs_world_t;
pub extern fn ecs_mini() ?*ecs_world_t;
pub extern fn ecs_init_w_args(argc: c_int, argv: [*c][*c]u8) ?*ecs_world_t;
pub extern fn ecs_fini(world: ?*ecs_world_t) c_int;
pub extern fn ecs_is_fini(world: ?*const ecs_world_t) bool;
pub extern fn ecs_atfini(world: ?*ecs_world_t, action: ecs_fini_action_t, ctx: ?*anyopaque) void;

pub const ecs_entities_t = extern struct {
    ids: [*c]const ecs_entity_t = @import("std").mem.zeroes([*c]const ecs_entity_t),
    count: i32 = @import("std").mem.zeroes(i32),
    alive_count: i32 = @import("std").mem.zeroes(i32),
};

pub extern fn ecs_get_entities(world: ?*const ecs_world_t) ecs_entities_t;
pub extern fn ecs_world_get_flags(world: ?*const ecs_world_t) ecs_flags32_t;
pub extern fn ecs_frame_begin(world: ?*ecs_world_t, delta_time: f32) f32;
pub extern fn ecs_frame_end(world: ?*ecs_world_t) void;
pub extern fn ecs_run_post_frame(world: ?*ecs_world_t, action: ecs_fini_action_t, ctx: ?*anyopaque) void;
pub extern fn ecs_quit(world: ?*ecs_world_t) void;
pub extern fn ecs_should_quit(world: ?*const ecs_world_t) bool;
pub extern fn ecs_measure_frame_time(world: ?*ecs_world_t, enable: bool) void;
pub extern fn ecs_measure_system_time(world: ?*ecs_world_t, enable: bool) void;
pub extern fn ecs_set_target_fps(world: ?*ecs_world_t, fps: f32) void;
pub extern fn ecs_set_default_query_flags(world: ?*ecs_world_t, flags: ecs_flags32_t) void;
pub extern fn ecs_readonly_begin(world: ?*ecs_world_t, multi_threaded: bool) bool;
pub extern fn ecs_readonly_end(world: ?*ecs_world_t) void;
pub extern fn ecs_merge(world: ?*ecs_world_t) void;
pub extern fn ecs_defer_begin(world: ?*ecs_world_t) bool;
pub extern fn ecs_is_deferred(world: ?*const ecs_world_t) bool;
pub extern fn ecs_defer_end(world: ?*ecs_world_t) bool;
pub extern fn ecs_defer_suspend(world: ?*ecs_world_t) void;
pub extern fn ecs_defer_resume(world: ?*ecs_world_t) void;
pub extern fn ecs_set_stage_count(world: ?*ecs_world_t, stages: i32) void;
pub extern fn ecs_get_stage_count(world: ?*const ecs_world_t) i32;
pub extern fn ecs_get_stage(world: ?*const ecs_world_t, stage_id: i32) ?*ecs_world_t;
pub extern fn ecs_stage_is_readonly(world: ?*const ecs_world_t) bool;
pub extern fn ecs_stage_new(world: ?*ecs_world_t) ?*ecs_world_t;
pub extern fn ecs_stage_free(stage: ?*ecs_world_t) void;
pub extern fn ecs_stage_get_id(world: ?*const ecs_world_t) i32;
pub extern fn ecs_set_ctx(world: ?*ecs_world_t, ctx: ?*anyopaque, ctx_free: ecs_ctx_free_t) void;
pub extern fn ecs_set_binding_ctx(world: ?*ecs_world_t, ctx: ?*anyopaque, ctx_free: ecs_ctx_free_t) void;
pub extern fn ecs_get_ctx(world: ?*const ecs_world_t) ?*anyopaque;
pub extern fn ecs_get_binding_ctx(world: ?*const ecs_world_t) ?*anyopaque;
pub extern fn ecs_get_build_info() [*c]const ecs_build_info_t;
pub extern fn ecs_get_world_info(world: ?*const ecs_world_t) [*c]const ecs_world_info_t;
pub extern fn ecs_dim(world: ?*ecs_world_t, entity_count: i32) void;
pub extern fn ecs_shrink(world: ?*ecs_world_t) void;
pub extern fn ecs_set_entity_range(world: ?*ecs_world_t, id_start: ecs_entity_t, id_end: ecs_entity_t) void;
pub extern fn ecs_enable_range_check(world: ?*ecs_world_t, enable: bool) bool;
pub extern fn ecs_get_max_id(world: ?*const ecs_world_t) ecs_entity_t;
pub extern fn ecs_run_aperiodic(world: ?*ecs_world_t, flags: ecs_flags32_t) void;

pub const ecs_delete_empty_tables_desc_t = extern struct {
    clear_generation: u16 = @import("std").mem.zeroes(u16),
    delete_generation: u16 = @import("std").mem.zeroes(u16),
    time_budget_seconds: f64 = @import("std").mem.zeroes(f64),
};

pub extern fn ecs_delete_empty_tables(world: ?*ecs_world_t, desc: [*c]const ecs_delete_empty_tables_desc_t) i32;
pub extern fn ecs_get_world(poly: ?*const ecs_poly_t) ?*const ecs_world_t;
pub extern fn ecs_get_entity(poly: ?*const ecs_poly_t) ecs_entity_t;
pub extern fn ecs_make_pair(first: ecs_entity_t, second: ecs_entity_t) ecs_id_t;
pub extern fn ecs_new(world: ?*ecs_world_t) ecs_entity_t;
pub extern fn ecs_new_low_id(world: ?*ecs_world_t) ecs_entity_t;
pub extern fn ecs_new_w_id(world: ?*ecs_world_t, id: ecs_id_t) ecs_entity_t;
pub extern fn ecs_new_w_table(world: ?*ecs_world_t, table: ?*ecs_table_t) ecs_entity_t;
pub extern fn ecs_entity_init(world: ?*ecs_world_t, desc: ?*const anyopaque) ecs_entity_t;
pub extern fn ecs_bulk_init(world: ?*ecs_world_t, desc: [*c]const ecs_bulk_desc_t) [*c]const ecs_entity_t;
pub extern fn ecs_bulk_new_w_id(world: ?*ecs_world_t, id: ecs_id_t, count: i32) [*c]const ecs_entity_t;
pub extern fn ecs_clone(world: ?*ecs_world_t, dst: ecs_entity_t, src: ecs_entity_t, copy_value: bool) ecs_entity_t;
pub extern fn ecs_delete(world: ?*ecs_world_t, entity: ecs_entity_t) void;
pub extern fn ecs_delete_with(world: ?*ecs_world_t, id: ecs_id_t) void;
pub extern fn ecs_add_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) void;
pub extern fn ecs_remove_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) void;
pub extern fn ecs_auto_override_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) void;
pub extern fn ecs_clear(world: ?*ecs_world_t, entity: ecs_entity_t) void;
pub extern fn ecs_remove_all(world: ?*ecs_world_t, id: ecs_id_t) void;
pub extern fn ecs_set_with(world: ?*ecs_world_t, id: ecs_id_t) ecs_entity_t;
pub extern fn ecs_get_with(world: ?*const ecs_world_t) ecs_id_t;
pub extern fn ecs_enable(world: ?*ecs_world_t, entity: ecs_entity_t, enabled: bool) void;
pub extern fn ecs_enable_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t, enable: bool) void;
pub extern fn ecs_is_enabled_id(world: ?*const ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) bool;
pub extern fn ecs_get_id(world: ?*const ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) ?*const anyopaque;
pub extern fn ecs_get_mut_id(world: ?*const ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) ?*anyopaque;
pub extern fn ecs_ensure_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) ?*anyopaque;
pub extern fn ecs_ensure_modified_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) ?*anyopaque;
pub extern fn ecs_ref_init_id(world: ?*const ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) ecs_ref_t;
pub extern fn ecs_ref_get_id(world: ?*const ecs_world_t, ref: [*c]ecs_ref_t, id: ecs_id_t) ?*anyopaque;
pub extern fn ecs_ref_update(world: ?*const ecs_world_t, ref: [*c]ecs_ref_t) void;
pub extern fn ecs_emplace_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t, is_new: [*c]bool) ?*anyopaque;
pub extern fn ecs_modified_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) void;
pub extern fn ecs_set_id(world: ?*ecs_world_t, entity: ecs_entity_t, id: ecs_id_t, size: usize, ptr: ?*const anyopaque) void;
pub extern fn ecs_is_valid(world: ?*const ecs_world_t, e: ecs_entity_t) bool;
pub extern fn ecs_is_alive(world: ?*const ecs_world_t, e: ecs_entity_t) bool;
pub extern fn ecs_strip_generation(e: ecs_entity_t) ecs_id_t;
pub extern fn ecs_get_alive(world: ?*const ecs_world_t, e: ecs_entity_t) ecs_entity_t;
pub extern fn ecs_make_alive(world: ?*ecs_world_t, entity: ecs_entity_t) void;
pub extern fn ecs_make_alive_id(world: ?*ecs_world_t, id: ecs_id_t) void;
pub extern fn ecs_exists(world: ?*const ecs_world_t, entity: ecs_entity_t) bool;
pub extern fn ecs_set_version(world: ?*ecs_world_t, entity: ecs_entity_t) void;
pub extern fn ecs_get_type(world: ?*const ecs_world_t, entity: ecs_entity_t) [*c]const ecs_type_t;
pub extern fn ecs_get_table(world: ?*const ecs_world_t, entity: ecs_entity_t) ?*ecs_table_t;
pub extern fn ecs_type_str(world: ?*const ecs_world_t, @"type": [*c]const ecs_type_t) [*c]u8;
pub extern fn ecs_table_str(world: ?*const ecs_world_t, table: ?*const ecs_table_t) [*c]u8;
pub extern fn ecs_entity_str(world: ?*const ecs_world_t, entity: ecs_entity_t) [*c]u8;
pub extern fn ecs_has_id(world: ?*const ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) bool;
pub extern fn ecs_owns_id(world: ?*const ecs_world_t, entity: ecs_entity_t, id: ecs_id_t) bool;
pub extern fn ecs_set_alias(world: ?*ecs_world_t, entity: ecs_entity_t, alias: [*c]const u8) void;
pub extern fn ecs_component_init(world: ?*ecs_world_t, desc: ?*const ecs_component_desc_t) ecs_entity_t;

pub const ecs_system_desc_t = extern struct {
    _canary: i32 = @import("std").mem.zeroes(i32),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    query: ecs_query_desc_t = @import("std").mem.zeroes(ecs_query_desc_t),
    callback: ecs_iter_action_t = null,
    run: ecs_run_action_t = @import("std").mem.zeroes(ecs_run_action_t),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    callback_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    callback_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    run_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    run_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    interval: f32 = @import("std").mem.zeroes(f32),
    rate: i32 = @import("std").mem.zeroes(i32),
    tick_source: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    multi_threaded: bool = @import("std").mem.zeroes(bool),
    immediate: bool = @import("std").mem.zeroes(bool),
};

pub extern fn ecs_system_init(world: ?*ecs_world_t, desc: [*c]const ecs_system_desc_t) ecs_entity_t;

pub const flecs_poly_dtor_t = opaque {};
pub const ecs_system_t = extern struct {
    hdr: ecs_header_t = @import("std").mem.zeroes(ecs_header_t),
    run: ecs_run_action_t = @import("std").mem.zeroes(ecs_run_action_t),
    action: ecs_iter_action_t = @import("std").mem.zeroes(ecs_iter_action_t),
    query: [*c]ecs_query_t = @import("std").mem.zeroes([*c]ecs_query_t),
    query_entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    tick_source: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    multi_threaded: bool = @import("std").mem.zeroes(bool),
    immediate: bool = @import("std").mem.zeroes(bool),
    name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    callback_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    run_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    callback_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    run_ctx_free: ecs_ctx_free_t = @import("std").mem.zeroes(ecs_ctx_free_t),
    time_spent: f32 = @import("std").mem.zeroes(f32),
    time_passed: f32 = @import("std").mem.zeroes(f32),
    last_frame: i64 = @import("std").mem.zeroes(i64),
    world: ?*ecs_world_t = @import("std").mem.zeroes(?*ecs_world_t),
    entity: ecs_entity_t = @import("std").mem.zeroes(ecs_entity_t),
    dtor: flecs_poly_dtor_t = @import("std").mem.zeroes(flecs_poly_dtor_t),
};

pub extern fn ecs_system_get(world: ?*const ecs_world_t, system: ecs_entity_t) [*c]const ecs_system_t;
pub extern fn ecs_run(world: ?*ecs_world_t, system: ecs_entity_t, delta_time: f32, param: ?*anyopaque) ecs_entity_t;
pub extern fn ecs_run_worker(world: ?*ecs_world_t, system: ecs_entity_t, stage_current: i32, stage_count: i32, delta_time: f32, param: ?*anyopaque) ecs_entity_t;

pub extern fn ecs_progress(world: ?*ecs_world_t, delta_time: ecs_ftime_t) bool;

pub extern fn ecs_field_w_size(it: *ecs_iter_t, size: usize, index: i8) ?*anyopaque;
