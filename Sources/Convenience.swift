
public func glGenBuffer() -> GLuint {
    var id = GLuint()
    __glGenBuffers(1, &id)
    return id
}

public func glDeleteBuffer(_ id: GLuint) {
    var copy = id
    __glDeleteBuffers(1, &copy)
}

public func glGenBuffers(_ count: Int) -> [GLuint] {
    let ids = [GLuint](repeating: 0, count: count)
    ids.withUnsafeBufferPointer { bufferPointer in
        __glGenBuffers(Int32(count), UnsafeMutablePointer(mutating: bufferPointer.baseAddress))
    }
    return ids
}

public func glDeleteBuffers(_ ids: [GLuint]) {
    ids.withUnsafeBufferPointer { bufferPointer in
        __glDeleteBuffers(Int32(ids.count), bufferPointer.baseAddress)
    }
}

public func glGenVertexArray() -> GLuint {
    var id = GLuint()
    __glGenVertexArrays(1, &id)
    return id
}

public func glDeleteVertexArray(_ id: GLuint) {
    var copy = id
    __glDeleteVertexArrays(1, &copy)
}

public func glGenVertexArrays(_ count: Int) -> [GLuint] {
    let ids = [GLuint](repeating: 0, count: count)
    ids.withUnsafeBufferPointer { bufferPointer in
        __glGenVertexArrays(Int32(count), UnsafeMutablePointer(mutating: bufferPointer.baseAddress))
    }
    return ids
}

public func glDeleteVertexArrays(_ ids: [GLuint]) {
    ids.withUnsafeBufferPointer { bufferPointer in
        __glDeleteVertexArrays(Int32(ids.count), bufferPointer.baseAddress)
    }
}

public func glShaderSources(_ shader: GLuint, sources: [String]) {
    let lengths = UnsafeMutablePointer<Int32>.allocate(capacity: sources.count)
    defer { lengths.deallocate(capacity: sources.count) }

    let utf8CStrings = sources.map { source in source.utf8CString }

    let sourcePointers = UnsafeMutablePointer<UnsafePointer<Int8>?>.allocate(capacity: sources.count)
    defer { sourcePointers.deallocate(capacity: sources.count) }

    for i in 0 ..< sources.count {
        lengths[i] = Int32(sources[i].characters.count)

        utf8CStrings[i].withUnsafeBufferPointer { bufferPointer in
            sourcePointers[i] = bufferPointer.baseAddress
        }
    }

    __glShaderSource(shader, Int32(sources.count), UnsafePointer(sourcePointers), lengths)
}

public func glShaderSource(_ shader: GLuint, source: String) {
    let shaderStringUTF8 = source.utf8CString

    shaderStringUTF8.withUnsafeBufferPointer { bufferPointer in
        var pointer = bufferPointer.baseAddress
        __glShaderSource(shader, 1, &pointer, nil)
    }
}

public func glGetProgramiv(_ program: GLuint, _ pname: GLenum) -> GLint {
    var value = GLint()
    __glGetProgramiv(program, pname, &value)
    return value
}

public func glGetShaderiv(_ shader: GLuint, _ pname: GLenum) -> GLint {
    var value = GLint()
    __glGetShaderiv(shader, pname, &value)
    return value
}

public func glGetShaderInfoLog(_ shader: GLuint) -> String {
    var maxLength = GLint()
    __glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &maxLength)

    let infoLog = UnsafeMutablePointer<CChar>.allocate(capacity: Int(maxLength))
    __glGetShaderInfoLog(shader, maxLength, nil, infoLog)

    let infoLogString = String(validatingUTF8: infoLog)!
    
    infoLog.deallocate(capacity: Int(maxLength))

    return infoLogString
}