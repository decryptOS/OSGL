
#if os(Linux)
    import Glibc
#elseif os(macOS)
    import Darwin
#endif

public struct SwiftGL {
    internal static var libGL: UnsafeMutableRawPointer!

    public static func load() {
        #if os(Linux) || os(macOS)
            SwiftGL.libGL = dlopen("libGL.so", RTLD_LAZY);
            if SwiftGL.libGL == nil {
                fatalError("Failed to load libGL.so")
            }

            loadAllGLFunctions()

            defer { dlclose(SwiftGL.libGL) }
        #endif
    }
}

internal func loadGLFunction<T>(named name: String, as: T.Type) -> T {
    return unsafeBitCast(dlsym(SwiftGL.libGL, name), to: T.self)
}
