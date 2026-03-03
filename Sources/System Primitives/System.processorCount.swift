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

extension System {
    /// Number of active/online logical processors (hardware threads).
    ///
    /// ## Platform Implementation
    /// - POSIX: `sysconf(_SC_NPROCESSORS_ONLN)`
    /// - Windows: `GetSystemInfo().dwNumberOfProcessors`
    ///
    /// ## Fallback
    /// Returns 1 if the syscall fails or returns invalid data.
    ///
    /// ## Usage
    /// ```swift
    /// let cpuCount = System.processorCount
    /// let workers = min(cpuCount, 8)
    /// ```
    @available(*, deprecated, message: "Use System.processor.count (typed) instead")
    @inlinable
    public static var processorCount: Int {
        #if hasFeature(Embedded)
        return 1  // Sensible default for embedded systems
        #elseif os(Windows)
        return _windowsProcessorCount
        #else
        let count = sysconf(Int32(_SC_NPROCESSORS_ONLN))
        return count > 0 ? Int(count) : 1
        #endif
    }
}

#if !hasFeature(Embedded)
#if os(Windows)
// PATTERN EXCEPTION: Global immutable cache (Rule 6.6)
//
// Justification: This is an immutable cache of system configuration that:
// - Never changes at runtime (hardware properties)
// - Is initialized exactly once on first access
// - Has no observable side effects
// - Cannot be testably injected (GetSystemInfo is a syscall)
private nonisolated(unsafe) let _cachedSystemInfo: SYSTEM_INFO = {
    var info = SYSTEM_INFO()
    GetSystemInfo(&info)
    return info
}()

@usableFromInline
internal var _windowsProcessorCount: Int {
    Int(_cachedSystemInfo.dwNumberOfProcessors)
}
#endif
#endif
