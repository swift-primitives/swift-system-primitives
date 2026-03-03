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
    /// Processor hardware information.
    ///
    /// Describes the system's processing hardware:
    /// - Logical processor (hardware thread) count
    /// - Physical processor (core) count
    ///
    /// ## Platform Implementation
    ///
    /// - POSIX: `sysconf(_SC_NPROCESSORS_ONLN)`
    /// - Windows: `GetSystemInfo().dwNumberOfProcessors`
    /// - Darwin: `sysctl("hw.physicalcpu")` for physical count
    public enum Processor {}
}

extension System.Processor {
    /// Number of processors.
    ///
    /// Type-safe wrapper for processor counts. Used for thread pool sizing,
    /// lane allocation, and other concurrency decisions.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let cpuCount = System.Processor.count
    /// let threads = Kernel.Thread.Count(cpuCount)
    /// ```
    public typealias Count = Tagged<System.Processor, Cardinal>
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

extension System.Processor {
    /// Number of active/online logical processors (hardware threads).
    ///
    /// ## Platform Implementation
    /// - POSIX: `sysconf(_SC_NPROCESSORS_ONLN)`
    /// - Windows: `GetSystemInfo().dwNumberOfProcessors`
    ///
    /// ## Fallback
    /// Returns 1 if the syscall fails or returns invalid data.
    @inlinable
    public static var count: Count {
        #if hasFeature(Embedded)
        Count(__unchecked: (), Cardinal(UInt(1)))
        #elseif os(Windows)
        _windowsProcessorCount
        #else
        let result = sysconf(Int32(_SC_NPROCESSORS_ONLN))
        return Count(__unchecked: (), Cardinal(UInt(result > 0 ? result : 1)))
        #endif
    }
}

#if !hasFeature(Embedded)
#if os(Windows)
private nonisolated(unsafe) let _cachedSystemInfo: SYSTEM_INFO = {
    var info = SYSTEM_INFO()
    GetSystemInfo(&info)
    return info
}()

@usableFromInline
internal var _windowsProcessorCount: System.Processor.Count {
    System.Processor.Count(__unchecked: (), Cardinal(UInt(_cachedSystemInfo.dwNumberOfProcessors)))
}
#endif
#endif

extension Int {
    /// Creates an Int from a processor count.
    @inlinable
    public init(_ count: System.Processor.Count) {
        self = Int(bitPattern: count)
    }
}
