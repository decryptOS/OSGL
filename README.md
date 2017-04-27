# OSGL
OpenSwiftGL (OSGL) is a lightweight Swift 3 compatible library, which makes OpenGL 3 and 4 functions ready to use.

# Installation
To use OSGL with the Swift Package Manager, simply add it to the dependencies in your Package.swift file:

``` swift
import PackageDescription

let package = Package(
	name: "Your-App-Name",
	dependencies: [
        	// ...
		.Package(url: "https://github.com/decryptOS/OSGL", majorVersion: 1),
        	// ...
	]
)
```

# Usage
All you have to do is to `import OSGL` in the .swift files, which need access to OpenGL.
At the beginning of your application you have to call `OSGL.load()` once to initialize.
