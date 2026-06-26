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
    /// A NUMA node representing a group of CPUs with local memory.
    ///
    /// ## Properties
    /// - `id`: Node identifier (0-based, matches OS node numbering)
    /// - `cpus`: Set of logical CPU IDs belonging to this node
    /// - `isSynthetic`: True if this node was synthesized for fallback
    ///
    /// ## Synthetic Nodes
    /// When NUMA is `.unavailable` or `.uniformAccess`, a single synthetic
    /// node may be created containing all CPUs. This allows uniform handling
    /// in sharding logic without special-casing non-NUMA systems.
    public struct Node: Sendable, Equatable, Identifiable {
        /// Node identifier (matches OS numbering).
        public let id: Int

        /// Set of logical CPU IDs belonging to this node.
        public let cpus: Set<Int>

        /// True if this node was synthesized (not discovered from hardware).
        ///
        /// Synthetic nodes are created for:
        /// - Platforms without NUMA discovery (`.unavailable`)
        /// - UMA systems (`.uniformAccess`)
        ///
        /// This allows uniform handling in sharding without special cases.
        public let isSynthetic: Bool

        /// Creates a NUMA node from an identifier, its CPU set, and a synthetic flag.
        public init(id: Int, cpus: Set<Int>, isSynthetic: Bool = false) {
            self.id = id
            self.cpus = cpus
            self.isSynthetic = isSynthetic
        }
    }
}
