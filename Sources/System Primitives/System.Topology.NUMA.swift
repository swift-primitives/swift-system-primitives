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

extension System.Topology {
    /// NUMA (Non-Uniform Memory Access) namespace.
    ///
    /// NUMA is a computer memory design where memory access time depends on
    /// the memory location relative to the processor. In NUMA systems, each
    /// processor has "local" memory that it can access faster than "remote"
    /// memory attached to other processors.
    public enum NUMA {}
}
