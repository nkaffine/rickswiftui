//
//  RuntimeParser.swift
//  RuntimeParser
//
//  Created by Nicholas Kaffine on 9/6/21.
//

import Foundation

struct RuntimeParser {
    static func parseRuntimeInMinutes(from runtimeString: String) -> Int? {
        let numerals = runtimeString.filter { char in
            char.isNumber
        }
        return Int(numerals)
    }
}
