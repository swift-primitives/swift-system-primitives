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

/// The System namespace provides hardware environment information.
///
/// System describes "what exists":
/// - CPU topology (processor count, NUMA nodes)
/// - Hardware capabilities
///
/// System does NOT:
/// - Perform thread operations (see Kernel.Thread)
/// - Set affinity (see Kernel.Thread.affinity)
/// - Manage synchronization (see Kernel.Lock, Kernel.Thread.Mutex)
public enum System {}

extension System {
    /// Nested accessor for processor-related properties.
    public static var processor: Processor.Type { Processor.self }

    /// Nested accessor for memory-related properties.
    public static var memory: Memory.Type { Memory.self }

    /// Nested accessor for page-related properties.
    public static var page: Page.Type { Page.self }
}
