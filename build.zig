const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.addModule("flecz", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "flecz",
        .root_module = lib_mod,
    });

    b.installArtifact(lib);

    const flecs = b.addStaticLibrary(.{
        .name = "flecs",
        .target = target,
        .optimize = optimize,
    });

    flecs.linkLibC();
    flecs.addIncludePath(b.path("external/flecs/"));

    const flecsFlags = .{
        "-fno-sanitize=undefined",
        "-DFLECS_NO_CPP",
        "-DFLECS_USE_OS_ALLOC",
        if (@import("builtin").mode == .Debug) "-DFLECS_SANITIZE" else "",
    };

    flecs.addCSourceFile(.{
        .file = b.path("external/flecs/flecs.c"),
        .flags = &flecsFlags,
    });

    b.installArtifact(flecs);

    hello_world_step(b, lib_mod, target, optimize);

    const lib_unit_tests = b.addTest(.{
        .root_module = lib_mod,
    });

    lib_unit_tests.linkLibC();
    lib_unit_tests.linkLibrary(flecs);
    lib_unit_tests.addIncludePath(b.path("external/flecs/"));

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}

fn hello_world_step(b: *std.Build, mod: anytype, target: anytype, optimize: anytype) void {
    const exe = b.addExecutable(.{
        .name = "hello_world",
        .root_source_file = b.path("examples/hello_world/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("flecs", mod);
    b.installArtifact(exe);

    const run_exe = b.step("hello_world", "Build Hello World Sample");
    run_exe.dependOn(&exe.step);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the Hello World Sample");
    run_step.dependOn(&run_cmd.step);
}
