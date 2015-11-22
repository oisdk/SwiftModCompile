//
//  SwiftModCompileTests.swift
//  SwiftModCompileTests
//
//  Created by Donnacha Oisín Kidney on 22/11/2015.
//  Copyright © 2015 Donnacha Oisín Kidney. All rights reserved.
//

import XCTest
@testable import SwiftModCompile

func testSccs<H:Hashable,C:CollectionType where C.Generator.Element == H>
  (graph: [H:C], sccs: Set<Set<H>>) {
    for (var scc) in sccs {
      guard let head = scc.popFirst() else { XCTAssert(false); return }
      if scc.isEmpty {
        XCTAssert((graph[head]?.contains(head))!)
        continue
      }
      var cur = head
      while true {
        guard let next = graph[cur].map(scc.intersect)?.first else { XCTAssert(false); return }
        if cur == head { break }
        cur = next
      }
    }
}

class SwiftModCompileTests: XCTestCase {
  func testSCC() {
//
//    A<---C<---E<-->G
//    |  / ^    ^    ^
//    v /^ |    |    |
//    B<---D<-->F<---H<-+
//                   |  |
//                   +--+
    let graph: [Character:[Character]] = [
      "A": ["B"],
      "B": ["C"],
      "C": ["A"],
      "D": ["B","C","F"],
      "E": ["C","G"],
      "F": ["D","E"],
      "G": ["E"],
      "H": ["F","G","H"]
    ]
    let sccs: Set<Set<Character>> = [
      ["A","B","C"],
      ["D","F"],
      ["E","G"],
      ["H"]
    ]
    XCTAssertEqual(sccs, tarjan(graph))
    testSccs(graph, sccs: tarjan(graph))
  }
}
