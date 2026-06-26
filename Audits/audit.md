# Audit: swift-system-primitives

## Legacy — Consolidated 2026-04-08

### From: swift-institute/Research/platform-compliance-audit.md (2026-03-19)

**Skill**: platform — [PLAT-ARCH-001-010], [PATTERN-001], [PATTERN-004a], [PATTERN-005]

| # | Severity | Rule | Location | Finding | Status |
|---|----------|------|----------|---------|--------|
| C-1 | CRITICAL | [PLAT-ARCH-008], [PLAT-ARCH-002] | System.Processor.swift:45-53 | Imports Darwin/Glibc/Musl/WinSDK to call `sysconf(_SC_NPROCESSORS_ONLN)` and `GetSystemInfo()` for CPU count. Fix: Move processor count query to swift-kernel-primitives as `Kernel.System.Processor.Count` accessor. | OPEN — Blocked by missing Kernel abstraction |
| C-2 | CRITICAL | [PLAT-ARCH-008], [PLAT-ARCH-002] | System.Page.swift:57-64 | Imports Darwin/Glibc/Musl/WinSDK to call `sysconf(_SC_PAGESIZE)` and `GetSystemInfo()` for page size. Fix: Move page size query to swift-kernel-primitives as `Kernel.System.Page.Size` accessor. | OPEN — Blocked by missing Kernel abstraction |

---

### From: swift-institute/Research/audits/implementation-naming-2026-03-20/swift-small-packages-batch.md (2026-03-20)

**Implementation + naming audit**

CLEAN - no findings
