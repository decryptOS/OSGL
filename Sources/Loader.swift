
#if os(Linux)
    import Glibc
#elseif os(macOS)
    import Darwin
#endif

public struct OSGL {
    internal static var libGL: UnsafeMutableRawPointer!

    public static func load() {
        #if os(Linux) || os(macOS)
            OSGL.libGL = dlopen("libGL.so", RTLD_LAZY);
            if OSGL.libGL == nil {
                fatalError("Failed to load libGL.so")
            }

            loadAllGLFunctions()

            defer { dlclose(OSGL.libGL) }
        #else
            fatalError("OSGL is not supported on this platform")
        #endif
    }
}

internal func loadGLFunction<T>(named name: String, as: T.Type) -> T {
    return unsafeBitCast(dlsym(OSGL.libGL, name), to: T.self)
}
