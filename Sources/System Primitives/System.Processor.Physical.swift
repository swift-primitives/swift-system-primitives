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

extension System.Processor {
    /// Physical processor types (excludes hyperthreading / efficiency-performance split).
    ///
    /// ## Platform Implementation
    ///
    /// - Darwin: `sysctl("hw.physicalcpu")`
    /// - Linux: Falls back to online processor count (POSIX)
    /// - Windows: Falls back to total processor count
    public enum Physical {}
}
