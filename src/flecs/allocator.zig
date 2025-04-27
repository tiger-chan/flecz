const std = @import("std");

const Self = @This();
const Header = struct {
    size: usize,
};
const ALIGNMENT = @sizeOf(Header);

fn alignHeader(size: anytype) usize {
    std.debug.assert(size > 0);
    return @as(usize, @intCast(size)) + @sizeOf(Header);
}

fn raw(ptr: *anyopaque) [*]u8 {
    return @ptrCast(@alignCast(ptr));
}


var dbg_alloc: usize = 0;
var dbg_max_alloc: usize = 0;
fn add_alloc(size: anytype) void {
    dbg_alloc += size;
    dbg_max_alloc = @max(dbg_max_alloc, dbg_alloc);
}
fn sub_alloc(size: anytype) void {
    trace_print(" sub_alloc {d} - {d}", .{ dbg_alloc, size });
    dbg_alloc -= @intCast(size);
}
fn print_alloc() void {
    trace_print(" FBA: {d}", .{ dbg_alloc });
}

fn print_max_alloc() void {
    // const stdout = std.io.getStdOut().writer();
    // stdout.print("\nFBA: {d} - {d}", .{ dbg_max_alloc, dbg_alloc }) catch @panic("Failed to write to stdout");
    //std.debug.print("\nFBA: {d} - {d}", .{ dbg_max_alloc, dbg_alloc });
}

fn trace_print(comptime fmt: []const u8, args: anytype) void {
    _ = fmt;
    _ = args;
    // const stdout = std.io.getStdOut().writer();
    // stdout.print(fmt, args) catch @panic("Failed to write to stdout");
    // std.debug.print(fmt, args);
}

var allocator: ?std.mem.Allocator = null;

pub fn init(mem_allocator: std.mem.Allocator) void {
    allocator = mem_allocator;
    trace_print("Initialized Flecs Allocator", .{});
}

pub fn deinit() void {
    print_max_alloc();
    allocator = null;
    dbg_alloc = 0;
    dbg_max_alloc = 0;
}

fn malloc_impl(size: usize) !struct { head: *Header, ptr: []u8 } {
    const sz = alignHeader(size);
    const mem = try allocator.?.alignedAlloc(u8, ALIGNMENT, sz);
    const head: *Header = @ptrCast(@alignCast(mem));
    head.* = Header{ .size = mem.len };

    const ptr: [*]u8 = mem.ptr + @sizeOf(Header);
    add_alloc(sz);
    return .{ .head = head, .ptr = ptr[0..(mem.len - @sizeOf(Header))] };
}

pub fn malloc(size: i32) callconv(.C) ?*anyopaque {
    const result = malloc_impl(@intCast(size)) catch return null; // @panic("Failed to malloc");

    trace_print("\nmealloc(size: {d}) -> [ size: {d}, ptr: {any} ]", .{ size, result.head.size, result.ptr.ptr });
    print_alloc();
    return result.ptr.ptr;
}

pub fn calloc(size: i32) callconv(.C) ?*anyopaque {
    const result = malloc_impl(@intCast(size)) catch return null; // @panic("Failed to calloc");
    @memset(result.ptr, 0);

    trace_print("\ncalloc(size: {d}) -> [ size: {d}, ptr: {any} ]", .{ size, result.head.size, result.ptr.ptr });
    print_alloc();
    return result.ptr.ptr;
}

pub fn realloc(ptr: ?*anyopaque, size: i32) callconv(.c) ?*anyopaque {
    if (ptr == null) {
        const result = malloc_impl(@intCast(size)) catch return null; // @panic("Failed to realloc");
        trace_print("\nrealloc(ptr: {any}, size: {d}) -> [ size: {d}, ptr: {any} ]", .{ ptr, size, result.head.size, result.ptr.ptr });
        return result.ptr.ptr;
    }

    const old_mem = raw(ptr.?);
    const old_head: *Header = @ptrCast(@alignCast(old_mem - @sizeOf(Header)));
    const old_size = old_head.size;

    const new_size: usize = @intCast(size);
    const result = malloc_impl(new_size) catch return null; // @panic("Failed to realloc");

    @memcpy(result.ptr[0..@min(old_size, new_size)], old_mem[0..@min(old_size, new_size)]);
    trace_print("\nrealloc(ptr: {any}, size: {d}) -> [ size: {d}, ptr: {any} ]", .{ ptr, size, result.head.size, result.ptr.ptr });
    sub_alloc(old_size + @sizeOf(Header));
    add_alloc(new_size + @sizeOf(Header));
    print_alloc();
    return result.ptr.ptr;
}

pub fn free(ptr: ?*anyopaque) callconv(.c) void {
    if (ptr == null) {
        return;
    }
    trace_print("\nfree(ptr: {any})", .{ptr});

    const safe_ptr: [*]u8 = raw(ptr.?);
    const del: [*]u8 = safe_ptr - @sizeOf(Header);
    const head: *Header = @ptrCast(@alignCast(del));
    sub_alloc(head.size);
    print_alloc();
    allocator.?.free(del[0..head.size]);
}
