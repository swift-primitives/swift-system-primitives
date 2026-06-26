// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-system open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-system project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import Memory_Alignment_Primitives

// MARK: - Conversions

extension Memory.Alignment {
    /// Creates an alignment from a page size.
    ///
    /// Page sizes are always powers of two and valid alignment values.
    @inlinable
    public init(_ pageSize: System.Page.Size) {
        // Page sizes from the kernel are always powers of 2
        // swift-format-ignore: NeverUseForceTry
        // swiftlint:disable:next force_try
        self = try! Memory.Alignment(Int(bitPattern: pageSize))
    }
}

extension System.Page.Size {
    /// Returns this page size as a `Memory.Alignment`.
    ///
    /// Page sizes are always valid alignment values.
    @inlinable
    public var alignment: Memory.Alignment {
        Memory.Alignment(self)
    }
}
