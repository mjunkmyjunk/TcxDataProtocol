//
//  Application.swift
//  TcxDataProtocol
//
//  Created by Kevin Hoogheem on 9/3/18.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// Identifies a PC software application
@available(swift 4.0)
public struct Application {
    /// Application_t

    /// Build Info
    private(set) public var build: Build?

    /// Language
    ///
    /// Specifies the two character ISO 693-1 language id that identifies
    /// the installed language of this application. see http://www.loc.gov/standards/iso639-2/
    /// for appropriate ISO identifiers
    private(set) public var language: String?

    /// Part Number
    private(set) public var partNumber: String?

    public init(build: Build?,
                language: String?,
                partNumber: String?)
    {
        self.build = build
        self.language = language
        self.partNumber = partNumber
    }
}

extension Application: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Application, rhs: Application) -> Bool {
        return (lhs.build == rhs.build) &&
            (lhs.language == rhs.language) &&
            (lhs.partNumber == rhs.partNumber)
    }
}

extension Application: Hashable {
    
    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.build)
        hasher.combine(self.language)
        hasher.combine(self.partNumber)
    }
}

@available(swift 4.0)
extension Application: Codable {

    /// Coding Keys
    public enum CodingKeys: String, CodingKey {
        case build = "Build"
        case language = "LangID"
        case partNumber = "PartNumber"
    }
}
