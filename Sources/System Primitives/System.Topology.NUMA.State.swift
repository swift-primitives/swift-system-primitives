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

extension System.Topology.NUMA {
    /// NUMA topology discovery state.
    ///
    /// ## Cases
    /// - `.unavailable`: Platform does not support NUMA discovery (e.g., macOS)
    /// - `.uniformAccess`: Single memory domain confirmed (no NUMA)
    /// - `.nonUniform`: Multiple NUMA nodes discovered
    ///
    /// ## Honest Reporting
    /// `.unavailable` means "cannot discover", not "discovered UMA".
    /// This distinction matters for making informed placement decisions.
    public enum State: Sendable, Equatable {
        /// NUMA topology discovery is not supported on this platform.
        ///
        /// This does NOT mean the system is UMA—it means we cannot determine
        /// the topology. Platform examples: macOS, iOS.
        case unavailable

        /// System has uniform memory access (single memory domain).
        ///
        /// All CPUs have equal access latency to all memory.
        /// This is confirmed via platform-specific discovery.
        case uniformAccess

        /// System has non-uniform memory access with multiple nodes.
        ///
        /// Each node contains CPUs and local memory. Access to remote
        /// memory (other nodes) has higher latency.
        case nonUniform(nodes: [Node])
    }
}
