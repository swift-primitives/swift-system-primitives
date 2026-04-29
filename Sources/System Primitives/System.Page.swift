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
    /// Memory page hardware information.
    ///
    /// The base page size is the MMU's minimum page table entry granularity.
    /// This is a hardware fact determined by the processor architecture.
    ///
    /// ## Platform Values
    ///
    /// - x86-64: Typically 4096 bytes
    /// - Apple Silicon: 16384 bytes
    /// - Windows: Typically 4096 bytes
    ///
    /// ## Platform Implementation
    ///
    /// The runtime page-size accessor lives in the platform stack:
    /// - POSIX: `swift-iso-9945` (`ISO_9945.System.pageSize`)
    /// - Windows: `swift-windows-standard` (`Windows.System.pageSize`)
    /// - Cross-platform: `swift-kernel` (`System.pageSize`)
    public enum Page {}
}

extension System.Page {
    /// Memory page size in bytes.
    ///
    /// The fundamental unit of memory management — the MMU's minimum
    /// page table entry granularity.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let pageSize = System.pageSize  // from swift-kernel (L3)
    /// let alignment = pageSize.alignment     // Memory.Alignment
    /// ```
    public typealias Size = Tagged<System.Page, Cardinal>
}

extension Int {
    /// Creates an Int from a page size.
    @inlinable
    public init(_ size: System.Page.Size) {
        self = Int(bitPattern: size)
    }
}
