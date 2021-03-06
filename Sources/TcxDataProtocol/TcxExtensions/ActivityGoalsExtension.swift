//
//  ActivityGoalsExtension.swift
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

// Schema
// https://www8.garmin.com/xmlschemas/ActivityGoalsExtensionv1.xsd

/// TCX Measure
@available(swift 4.0)
public enum Measure: String, Codable {
    // Measure_t

    /// Distance in Meters
    case distanceMeters = "DistanceMeters"
    /// Time in Seconds
    case timeSeconds = "TimeSeconds"
    /// Number of Sessions
    case numberOfSessions = "NumberOfSessions"
    /// Calories
    case calories = "Calories"
}

/// TCX Recurrence Code
@available(swift 4.0)
public enum RecurrenceCode: String, Codable {
    // RecurrenceCode_t

    /// Once
    case once = "Once"
    /// Daily
    case daily = "Daily"
    /// Weekly
    case weekly = "Weekly"
    /// Monthly
    case monthly = "Monthly"
    /// Yearly
    case yearly = "Yearly"
    /// Custom
    case custom = "Custom"
}

/// TCX Period
@available(swift 4.0)
public struct Period {
    // Period_t

    /// Start Date
    private(set) public var startDate: Date

    /// End Date
    private(set) public var endDate: Date?

    /// Recurrence
    private(set) public var recurrence: RecurrenceCode

    /// Days Per Period
    ///
    /// - note: Default is 7, max 356
    private(set) public var daysPerPeriod: UInt16

    public init(startDate: Date,
                endDate: Date?,
                recurrence: RecurrenceCode,
                daysPerPeriod: UInt16 = 7)
    {
        self.startDate = startDate
        self.endDate = endDate
        self.recurrence = recurrence
        self.daysPerPeriod = min(daysPerPeriod, 356)
    }
}

extension Period: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Period, rhs: Period) -> Bool {
        return (lhs.startDate == rhs.startDate) &&
            (lhs.endDate == rhs.endDate) &&
            (lhs.recurrence == rhs.recurrence) &&
            (lhs.daysPerPeriod == rhs.daysPerPeriod)
    }
}

extension Period: Hashable {
    
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
        hasher.combine(self.startDate)
        hasher.combine(self.endDate)
        hasher.combine(self.recurrence)
        hasher.combine(self.daysPerPeriod)
    }
}

@available(swift 4.0)
extension Period: Codable {

    /// Coding Keys
    public enum CodingKeys: String, CodingKey {
        // xsd:dateTime
        case startDate = "StartDateTime"
        // xsd:dateTime
        case endDate = "EndDateTime"
        case recurrence = "Recurrence"
        case daysPerPeriod = "DaysPerPeriod"
    }
}

/// TCX Activity Goal
@available(swift 4.0)
public struct ActivityGoal {
    // ActivityGoal_t

    /// Sport
    private(set) public var sport: Sport

    /// Measure
    private(set) public var measure: Measure

    /// Target
    private(set) public var target: Float

    /// Current
    private(set) public var current: Float

    /// Name
    private(set) public var name: String

    /// Period
    private(set) public var period: Period?

    public init(sport: Sport,
                measure: Measure,
                target: Float,
                current: Float,
                name: String,
                period: Period?)
    {
        self.sport = sport
        self.measure = measure
        self.target = target
        self.current = current
        self.name = name
        self.period = period
    }
}

extension ActivityGoal: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: ActivityGoal, rhs: ActivityGoal) -> Bool {
        return (lhs.sport == rhs.sport) &&
            (lhs.measure == rhs.measure) &&
            (lhs.target == rhs.target) &&
            (lhs.current == rhs.current) &&
            (lhs.name == rhs.name) &&
            (lhs.period == rhs.period)
    }
}

extension ActivityGoal: Hashable {
    
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
        hasher.combine(self.measure)
        hasher.combine(self.target)
        hasher.combine(self.current)
        hasher.combine(self.name)
        hasher.combine(self.period)
    }
}

@available(swift 4.0)
extension ActivityGoal: Codable {

    /// Coding Keys
    public enum CodingKeys: String, CodingKey {
        // attribute
        case sport = "Sport"
        // attribute
        case measure = "Measure"
        // attribute
        case target = "Target"
        // attribute
        case current = "Current"

        case name = "Name"
        case period = "Period"
    }
}

/// TCX Activity Goals
@available(swift 4.0)
public struct ActivityGoals {
    // ActivityGoals_t

    /// Activity Goals
    private(set) public var goals: [ActivityGoal]

    public init(goals: [ActivityGoal]) {
        self.goals = goals
    }
}

extension ActivityGoals: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: ActivityGoals, rhs: ActivityGoals) -> Bool {
        return (lhs.goals == rhs.goals)
    }
}

extension ActivityGoals: Hashable {
    
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
        hasher.combine(self.goals)
    }
}

@available(swift 4.0)
extension ActivityGoals: Codable {

    /// Coding Keys
    public enum CodingKeys: String, CodingKey {
        case goals = "ns5:activityGoal"
    }

    /// Alternate Coding Keys
    public enum AlternateCodingKeys: String, CodingKey {
        case goals = "ActivityGoal"
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringKey.self)
        var goals: [ActivityGoal]?

        goals = try container.lazyDecode([ActivityGoal].self,
                                            keyOne: StringKey(stringValue: CodingKeys.goals.rawValue)!,
                                            keyTwo: StringKey(stringValue: AlternateCodingKeys.goals.rawValue)!)

        if let goals = goals {
            self.init(goals: goals)
        } else {
            self.init(goals: [ActivityGoal]())
        }
    }

}
