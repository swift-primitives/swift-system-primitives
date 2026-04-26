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
    /// The runtime processor-count accessor lives in the platform stack:
    /// - POSIX: `swift-iso-9945` (`ISO_9945.Kernel.System.processorCount`)
    /// - Windows: `swift-windows-standard` (`Windows.Kernel.System.processorCount`)
    /// - Cross-platform: `swift-kernel` (`Kernel.System.Processor.count`)
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
    /// let cpuCount = Kernel.System.Processor.count  // from swift-kernel (L3)
    /// let threads = Kernel.Thread.Count(cpuCount)
    /// ```
    public typealias Count = Tagged<System.Processor, Cardinal>

    /// Identifies a specific logical processor.
    ///
    /// Ordinal complement to ``Count``: Count answers "how many processors",
    /// ID answers "which processor". Used for CPU affinity, pinning threads
    /// or poll loops to a specific core.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let cpu: System.Processor.ID = 0
    /// var thread = Kernel.IO.Uring.Params.Submission.Thread(cpu: cpu)
    /// ```
    public typealias ID = Tagged<System.Processor, Ordinal>
}

extension Int {
    /// Creates an Int from a processor count.
    @inlinable
    public init(_ count: System.Processor.Count) {
        self = Int(bitPattern: count)
    }
}
