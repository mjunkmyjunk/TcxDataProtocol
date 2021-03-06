//
//  Activity.swift
//  TcxDataProtocol
//
//  Created by Kevin Hoogheem on 12/31/18.
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
import XMLCoder

/// TCX Activity
@available(swift 4.0)
public struct Activity {
    // Activity_t

    /// Sport
    private(set) public var sport: Sport

    /// Activity ID
    private(set) public var identification: Date

    /// Lap
    private(set) public var lap: [ActivityLap]

    /// Notes
    private(set) public var notes: String?

    /// Training
    private(set) public var training: Training?

    /// Creator
    private(set) public var creator: Creator?

    public init(sport: Sport,
                identification: Date,
                lap: [ActivityLap],
                notes: String?,
                training: Training?,
                creator: Creator?)
    {
        self.sport = sport
        self.identification = identification
        self.lap = lap
        self.notes = notes
        self.training = training
        self.creator = creator
    }
}

extension Activity: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Activity, rhs: Activity) -> Bool {
        return (lhs.sport == rhs.sport) &&
            (lhs.identification == rhs.identification) &&
            (lhs.lap == rhs.lap) &&
            (lhs.notes == rhs.notes) &&
            (lhs.training == rhs.training)  &&
            (lhs.creator == rhs.creator)
    }
}

extension Activity: Hashable {
    
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
        hasher.combine(self.sport)
        hasher.combine(self.identification)
        hasher.combine(self.lap)
        hasher.combine(self.notes)
        hasher.combine(self.training)
        hasher.combine(self.creator)
    }
}

@available(swift 4.0)
extension Activity: Codable {

    /// Coding Keys
    public enum CodingKeys: String, CodingKey {
        // attribute
        case sport = "Sport"

        // xsd:dateTime
        case identification = "Id"
        case lap = "Lap"
        case notes = "Notes"
        case training = "Training"
        case creator = "Creator"
    }
}

extension Activity: DynamicNodeEncoding {
    
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case Activity.CodingKeys.sport:
            return .attribute
        default:
            return .element
        }
    }
}
