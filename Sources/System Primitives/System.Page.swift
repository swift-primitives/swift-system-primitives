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
    /// - POSIX: `sysconf(_SC_PAGESIZE)`
    /// - Windows: `GetSystemInfo().dwPageSize`
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
    /// let pageSize = System.Page.size
    /// let alignment = pageSize.alignment  // Memory.Alignment
    /// ```
    public typealias Size = Tagged<System.Page, Cardinal>
}

// MARK: - Accessor

#if !hasFeature(Embedded)
#if canImport(Darwin)
public import Darwin
#elseif canImport(Glibc)
public import Glibc
#elseif canImport(Musl)
public import Musl
#elseif os(Windows)
@preconcurrency public import WinSDK
#endif
#endif

extension System.Page {
    /// The system's memory page size in bytes.
    ///
    /// ## Platform Implementation
    /// - POSIX: `sysconf(_SC_PAGESIZE)`
    /// - Windows: `GetSystemInfo().dwPageSize`
    ///
    /// ## Typical Values
    /// - x86-64: 4096 bytes
    /// - Apple Silicon: 16384 bytes
    @inlinable
    public static var size: Size {
        #if hasFeature(Embedded)
        Size(__unchecked: (), Cardinal(UInt(4096)))
        #elseif os(Windows)
        _windowsPageSize
        #else
        Size(__unchecked: (), Cardinal(UInt(sysconf(Int32(_SC_PAGESIZE)))))
        #endif
    }
}

#if !hasFeature(Embedded)
#if os(Windows)
@usableFromInline
internal var _windowsPageSize: System.Page.Size {
    System.Page.Size(__unchecked: (), Cardinal(UInt(_cachedSystemInfo.dwPageSize)))
}
#endif
#endif

extension Int {
    /// Creates an Int from a page size.
    @inlinable
    public init(_ size: System.Page.Size) {
        self = Int(bitPattern: size)
    }
}

