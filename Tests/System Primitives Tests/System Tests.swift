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

    @Test("Processor.count returns positive value")
    func processorCountReturnsPositiveValue() {
        let count = System.Processor.count
        #expect(count >= .one)
    }

    @Test("Synthetic node creation")
    func syntheticNodeCreation() {
        let cpuCount = Int(System.Processor.count)
        let syntheticNode = System.Topology.NUMA.Node(
            id: 0,
            cpus: Set(0..<cpuCount),
            isSynthetic: true
        )
        #expect(syntheticNode.isSynthetic == true)
        #expect(syntheticNode.cpus.count == cpuCount)
    }
}
