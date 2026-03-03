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
    /// System memory hardware information.
    ///
    /// Describes the system's installed physical memory.
    ///
    /// ## Platform Implementation
    ///
    /// - Darwin: `sysctl("hw.memsize")`
    /// - Linux: `sysinfo().totalram × mem_unit`
    /// - Windows: `GlobalMemoryStatusEx().ullTotalPhys`
    public enum Memory {}
}

extension System.Memory {
    /// Total physical memory capacity in bytes.
    ///
    /// A type-safe wrapper for the system's total installed RAM.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let totalRAM = System.Memory.total
    /// let totalGB = UInt64(totalRAM) / (1024 * 1024 * 1024)
    /// ```
    public typealias Capacity = Tagged<System.Memory, Cardinal>
}

extension UInt64 {
    /// Creates a UInt64 from a memory capacity value.
    @inlinable
    public init(_ capacity: System.Memory.Capacity) {
        self = UInt64(Int(bitPattern: capacity))
    }
}

extension Int {
    /// Creates an Int from a memory capacity value.
    @inlinable
    public init(_ capacity: System.Memory.Capacity) {
        self = Int(bitPattern: capacity)
    }
}
