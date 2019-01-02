//
//  Creator.swift
//  TcxDataProtocol
//
//  Created by Kevin Hoogheem on 12/29/18.
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

/// Identifies Creator Information
@available(swift 4.0)
public struct Creator {
    // AbstractSource_t

    /// Type
    private(set) public var type: String?

    /// Creator Name
    ///
    /// This represents a Device name
    private(set) public var name: String

    /// Version
    private(set) public var version: Version?

    /// Unit Identification
    private(set) public var unitIdentification: String?

    /// Product Identification
    private(set) public var productIdentification: String?

    public init(name: String,
                version: Version?,
                unitIdentification: String?,
                productIdentification: String?)
    {
        self.type = "Device_t"
        self.name = name
        self.version = version
        self.unitIdentification = unitIdentification
        self.productIdentification = productIdentification
    }
}

@available(swift 4.0)
extension Creator: Codable {

    /// Coding Keys
    public enum CodingKeys: String, CodingKey {
        // attribute
        case type = "xsi:type"

        case name = "Name"
        case version = "Version"
        case unitIdentification = "UnitId"
        case productIdentification = "ProductID"
    }
}