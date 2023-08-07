const std = @import("std");
const c = @cImport({
    @cInclude("GL/gl.h");
    @cInclude("glfw3.h");
});

pub fn main() !void {
    _ = c.glfwSetErrorCallback(errorCallback);
    const err = c.glfwInit();
    if (err == c.GLFW_FALSE) return error.GLFWInitFailure;
    defer c.glfwTerminate();

    const window = c.glfwCreateWindow(640, 480, "Hello World", null, null);
    if (window == null) {
        return error.FailedToOpenWindow;
    }

    c.glfwMakeContextCurrent(window);

    while (c.glfwWindowShouldClose(window) == c.GLFW_FALSE) {
        c.glClear(c.GL_COLOR_BUFFER_BIT);
        c.glfwSwapBuffers(window);
        c.glfwPollEvents();
    }

    c.glfwTerminate();
}

fn errorCallback(code: c_int, desc: [*c]const u8) callconv(.C) void {
    std.debug.print("ERROR [{x}]: {s}\n", .{ code, desc });
}
