//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift.org project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import JExtractSwift
import XCTest

func assertOutput(_ got: String, expected: String, file: StaticString = #filePath, line: UInt = #line) {
  let gotLines = got.split(separator: "\n")
  let expectedLines = expected.split(separator: "\n")

  var diffLineNumbers: [Int] = []

  for (no, (g, e)) in zip(gotLines, expectedLines).enumerated() {
    if g.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
      || e.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
    {
      continue
    }

    let ge = g.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let ee = e.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    if ge != ee {
      //      print("")
      //      print("[\(file):\(line)] " + "Difference found on line: \(no + 1)!".red)
      //      print("Expected @ \(file):\(Int(line) + no + 3 /*formatting*/ + 1):")
      //      print(e.yellow)
      //      print("Got instead:")
      //      print(g.red)

      diffLineNumbers.append(no)

      XCTAssertEqual(ge, ee, file: file, line: line)
    }

  }

  if diffLineNumbers.count > 0 {
    print("")
    print("error: Number of not matching lines: \(diffLineNumbers.count)!".red)

    print("==== ---------------------------------------------------------------")
    print("Expected output:")
    for (n, e) in expectedLines.enumerated() {
      print("\(e)".yellow(if: diffLineNumbers.contains(n)))
    }
    print("==== ---------------------------------------------------------------")
    print("Got output:")
    for (n, g) in gotLines.enumerated() {
      print("\(g)".red(if: diffLineNumbers.contains(n)))
    }
    print("==== ---------------------------------------------------------------\n")
  }
}
