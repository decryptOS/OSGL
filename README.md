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
To use OSGL you simply have to call `import OSGL` and all OpenGL constants and functions become available.
To initialize OSGL you have to call `OSGL.load()` once at the beginning of your application.
