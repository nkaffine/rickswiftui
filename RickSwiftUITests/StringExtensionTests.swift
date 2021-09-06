//
//  StringExtensionTests.swift
//  StringExtensionTests
//
//  Created by Nicholas Kaffine on 9/6/21.
//

import XCTest
@testable import RickSwiftUI

class StringExtensionTests: XCTestCase {

    func testRemovingLeadingWhitespaceRemovesLeadingWhitespaceWithoutMutating() {
        let stringToStrip = " with leading whitespace"
        let strippedString = stringToStrip.removingLeadingWhiteSpace()
        XCTAssertEqual("with leading whitespace", strippedString)
        XCTAssertEqual(" with leading whitespace", stringToStrip)
    }

    func testRemovingTrailingWhitespaceRemovesTrailingWhitespaceWithoutMutating() {
        let stringToStrip = "with trailing whitespace "
        let strippedString = stringToStrip.removingTrailingWhiteSpace()
        XCTAssertEqual("with trailing whitespace", strippedString)
        XCTAssertEqual("with trailing whitespace ", stringToStrip)
    }

    func testRemovingOnlyTrailingOnlyRemovesTrailing() {
        let stringToStrip = " with trailing and leading whitespace "
        let strippedString = stringToStrip.removingTrailingWhiteSpace()
        XCTAssertEqual(" with trailing and leading whitespace", strippedString)
    }

    func testRemovingOnlyLeadingOnlyRemovesLeading() {
        let stringToStrip = " with trailing and leading whitespace "
        let strippedString = stringToStrip.removingLeadingWhiteSpace()
        XCTAssertEqual("with trailing and leading whitespace ", strippedString)
    }

    func testRemovingLeadingFromEmptyStringDoesNothing() {
        let emptyString = ""
        let strippedString = emptyString.removingLeadingWhiteSpace()
        XCTAssertEqual("", strippedString)
    }

    func testRemovingTrailingFromEmptyStringDoesNothing() {
        let emptyString = ""
        let strippedString = emptyString.removingTrailingWhiteSpace()
        XCTAssertEqual("", strippedString)
    }

    func testRemovingTrailingWhereThereIsNoneDoesNothing() {
        let stringWithNoTrailingWhiteSpace = " this has no trailing whitespace"
        let strippedString = stringWithNoTrailingWhiteSpace.removingTrailingWhiteSpace()
        XCTAssertEqual(stringWithNoTrailingWhiteSpace, strippedString)
    }

    func testRemovingLeadingWhereThereIsNoneDoesNothing() {
        let stringWithNoLeadingWhiteSpace = "this has not leading whitespace "
        let strippedString = stringWithNoLeadingWhiteSpace.removingLeadingWhiteSpace()
        XCTAssertEqual(stringWithNoLeadingWhiteSpace, strippedString)
    }
}
