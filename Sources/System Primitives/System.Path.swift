// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-system-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-system-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension System {
    /// Path-related types.
    public enum Path {}
}

// MARK: - Path.Length

extension System.Path {
    /// Maximum path length in bytes.
    ///
    /// A type-safe wrapper for the platform's maximum path length.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let maxLen = System.path.max
    /// guard path.count <= Int(maxLen) else {
    ///     throw PathTooLongError()
    /// }
    /// ```
    public typealias Length = Tagged<System.Path, Cardinal>
}

// MARK: - Int Conversion

extension Int {
    /// Creates an Int from a path length for comparison.
    @inlinable
    public init(_ length: System.Path.Length) {
        self = Int(bitPattern: length)
    }
}
