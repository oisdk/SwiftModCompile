//
//  SwiftModCompileTests.swift
//  SwiftModCompileTests
//
//  Created by Donnacha Oisín Kidney on 22/11/2015.
//  Copyright © 2015 Donnacha Oisín Kidney. All rights reserved.
//

import XCTest
@testable import SwiftModCompile

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
  }
}
