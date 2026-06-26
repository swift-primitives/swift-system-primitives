# System Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Hardware-environment value types for Swift — a `System` namespace of CPU topology, NUMA layout, memory/page/processor measurements, and OS identification, with zero platform dependencies.

---

## Quick Start

`System` is a vocabulary of types describing "what the hardware is": logical CPU count, NUMA node layout, total memory, page size, processor counts. It holds the *shapes* only — no `sysctl`, no `uname`, no C imports — so the same values travel unchanged from a platform package that discovers them (kernel / POSIX / Windows) through every layer that consumes them.

```swift
import System_Primitives

// Describe a NUMA node: which logical CPUs share a local memory domain.
let node = System.Topology.NUMA.Node(id: 0, cpus: [0, 1, 2, 3], isSynthetic: false)

// Assemble a full hardware topology.
let topology = System.Topology(cpuCount: 4, numa: .nonUniform(nodes: [node]))

print(topology.cpuCount)   // 4
if case .nonUniform(let nodes) = topology.numa {
    print(nodes.first?.cpus.count ?? 0)   // 4
}
```

`Topology.NUMA.State` is a three-case enum that reports discovery *honestly*: `.unavailable` (the platform can't determine NUMA, e.g. macOS), `.uniformAccess` (confirmed single memory domain), and `.nonUniform(nodes:)` (multiple nodes discovered). `.unavailable` is distinct from `.uniformAccess` — "cannot discover" is not "discovered UMA" — so placement decisions stay informed.

Hardware measurements are phantom-tagged integers — distinct types that cannot be accidentally crossed:

```swift
import System_Primitives

let totalRAM: System.Memory.Capacity = 17_179_869_184   // 16 GiB, in bytes
let pageSize: System.Page.Size = 16_384                 // Apple Silicon
let cpuCount: System.Processor.Count = 8

// Each carries its meaning in the type. Cross to a plain Int only at the boundary.
let gigabytes = UInt64(totalRAM) / (1024 * 1024 * 1024)   // 16
let alignment = pageSize.alignment                         // Memory.Alignment

print(gigabytes, Int(cpuCount))   // 16 8
```

`System.Memory.Capacity`, `System.Page.Size`, `System.Processor.Count`, `System.Path.Length` are `Tagged<_, Cardinal>` (counts and sizes); `System.Processor.ID` is `Tagged<_, Ordinal>` (which processor, not how many). `System.Name` captures the `system` / `release` / `machine` triple (the POSIX `utsname` fields). Runtime discovery of these values lives in downstream platform packages; this package is the shared vocabulary they populate.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-system-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "System Primitives", package: "swift-system-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Two library products. Depends only on the `Cardinal`, `Ordinal`, and `Memory.Alignment` primitives.

| Product | Target | Purpose |
|---------|--------|---------|
| `System Primitives` | `Sources/System Primitives/` | The `System` namespace: `System.Topology` + `System.Topology.NUMA` (`State`, `Node`); `System.Name`; and the phantom-tagged measurements `System.Memory.Capacity`, `System.Page.Size`, `System.Processor.{Count, ID}`, `System.Path.Length`. |
| `System Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
