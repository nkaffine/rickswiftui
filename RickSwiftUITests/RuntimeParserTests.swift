//
//  RickSwiftUITests.swift
//  RickSwiftUITests
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import XCTest
@testable import RickSwiftUI

class RuntimeParserTests: XCTestCase {

    func testParsingRuntimeSucceeds() {
        let runtime = "186 min"
        XCTAssertEqual(RuntimeParser.parseRuntimeInMinutes(from: runtime), 186)
    }

    func testParsingBadRuntimeFails() {
        let runtime = "something that isnt a number"
        XCTAssertNil(RuntimeParser.parseRuntimeInMinutes(from: runtime))
    }
}
