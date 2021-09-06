//
//  StringHelpers.swift
//  StringHelpers
//
//  Created by Nicholas Kaffine on 9/6/21.
//

import Foundation

extension String {
    /// Removes the character at the given index if the character is whitespace. If the string is an empty string or the index is out of range, a copy of the original string is returned.
    private func removingWhitespace(at index: String.Index) -> String {
        if self.count == 0 || !self.indices.contains(index) {
            return String(self)
        }
        var copy = String(self)
        if self[index].isWhitespace {
            copy.remove(at: index)
            return copy
        } else {
            return copy
        }
    }

    /// Returns a new string without the whitespace at the beginning of this string if there is any. If the string is empty, an empty string is returned.
    func removingLeadingWhiteSpace() -> String {
        return self.removingWhitespace(at: self.startIndex)
    }

    /// Returns a new string without the whitesapce at the end of this string if there us any. If the string is empty, an empty string is returned.
    func removingTrailingWhiteSpace() -> String {
        switch count {
            case 0:
                return String(self)
            case 1:
                return self.removingLeadingWhiteSpace()
            default:
                return self.removingWhitespace(at: self.index(before: self.endIndex))
        }
    }
}
