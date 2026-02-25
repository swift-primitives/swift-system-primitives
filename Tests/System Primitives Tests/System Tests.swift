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

import Testing
@testable import System_Primitives

@Suite("System")
struct SystemTests {

    @Test("processorCount returns positive value")
    func processorCountReturnsPositiveValue() {
        let count = System.processorCount
        #expect(count >= 1)
    }

    @Test("Topology types are constructible")
    func topologyTypesAreConstructible() {
        let node = System.Topology.NUMA.Node(
            id: 0,
            cpus: [0, 1, 2, 3],
            isSynthetic: false
        )
        #expect(node.id == 0)
        #expect(node.cpus.count == 4)
        #expect(node.isSynthetic == false)

        let topology = System.Topology(
            cpuCount: 4,
            numa: .nonUniform(nodes: [node])
        )
        #expect(topology.cpuCount == 4)
        if case .nonUniform(let nodes) = topology.numa {
            #expect(nodes.count == 1)
        } else {
            Issue.record("Expected .nonUniform")
        }
    }

    @Test("NUMA State cases")
    func numaStateCases() {
        let unavailable = System.Topology.NUMA.State.unavailable
        let uniform = System.Topology.NUMA.State.uniformAccess
        let nonUniform = System.Topology.NUMA.State.nonUniform(nodes: [])

        #expect(unavailable == .unavailable)
        #expect(uniform == .uniformAccess)
        #expect(nonUniform == .nonUniform(nodes: []))
    }

    @Test("Synthetic node creation")
    func syntheticNodeCreation() {
        let syntheticNode = System.Topology.NUMA.Node(
            id: 0,
            cpus: Set(0..<System.processorCount),
            isSynthetic: true
        )
        #expect(syntheticNode.isSynthetic == true)
        #expect(syntheticNode.cpus.count == System.processorCount)
    }
}
