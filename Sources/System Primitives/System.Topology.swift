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
    /// Hardware topology information.
    ///
    /// Describes the system's CPU and memory topology including:
    /// - Processor count
    /// - NUMA node configuration
    ///
    /// ## Usage
    /// ```swift
    /// let topology = System.topology()
    /// print("CPUs: \(topology.cpuCount)")
    /// print("NUMA: \(topology.numa)")
    /// ```
    public struct Topology: Sendable, Equatable {
        /// Number of logical CPUs (hardware threads).
        public let cpuCount: Int

        /// NUMA topology state.
        public let numa: NUMA.State

        public init(cpuCount: Int, numa: NUMA.State) {
            self.cpuCount = cpuCount
            self.numa = numa
        }
    }
}
