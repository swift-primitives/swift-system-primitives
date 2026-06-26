// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-system-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-system-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension System {
    /// Operating system identification.
    ///
    /// Captures the system name, release version, and hardware type.
    /// On POSIX systems, these correspond to the `utsname` fields from `uname()`.
    ///
    /// ## Platform Implementation
    ///
    /// - POSIX: `swift-iso-9945` (`ISO_9945.System.name`) via `uname()`
    /// - Windows: `swift-windows` (`Windows.System.name`) via `RtlGetVersion()`
    public struct Name: Sendable, Hashable {
        /// System implementation name (e.g., "Darwin", "Linux").
        ///
        /// Corresponds to POSIX `utsname.sysname`.
        public var system: Swift.String

        /// Current release level (e.g., "24.3.0", "6.1.0").
        ///
        /// Corresponds to POSIX `utsname.release`.
        public var release: Swift.String

        /// Hardware type (e.g., "arm64", "x86_64").
        ///
        /// Corresponds to POSIX `utsname.machine`.
        public var machine: Swift.String

        /// Creates an identification from system name, release, and machine type.
        public init(
            system: Swift.String,
            release: Swift.String,
            machine: Swift.String
        ) {
            self.system = system
            self.release = release
            self.machine = machine
        }
    }
}
