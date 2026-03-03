// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-system open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-system project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension System {
    /// Processor hardware information.
    ///
    /// Describes the system's processing hardware:
    /// - Logical processor (hardware thread) count
    /// - Physical processor (core) count
    ///
    /// ## Platform Implementation
    ///
    /// - POSIX: `sysconf(_SC_NPROCESSORS_ONLN)`
    /// - Windows: `GetSystemInfo().dwNumberOfProcessors`
    /// - Darwin: `sysctl("hw.physicalcpu")` for physical count
    public enum Processor {}
}

extension System.Processor {
    /// Number of processors.
    ///
    /// Type-safe wrapper for processor counts. Used for thread pool sizing,
    /// lane allocation, and other concurrency decisions.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let cpuCount = System.processor.count
    /// let threads = Kernel.Thread.Count(cpuCount)
    /// ```
    public typealias Count = Tagged<System.Processor, Cardinal>
}

extension Int {
    /// Creates an Int from a processor count.
    @inlinable
    public init(_ count: System.Processor.Count) {
        self = Int(bitPattern: count)
    }
}
