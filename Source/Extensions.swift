//
//  Extensions.swift
//  Arrow
//
//  Created by Max Konovalov on 07/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

// MARK: - Plain types

extension String {
    /// Construct a `String` from JSON
    public init?(_ json: JSON?) {
        var x: String?
        x <-- json
        guard let s = x else {
            return nil
        }
        self.init(s)
    }
}

extension Int {
    /// Construct an `Int` from JSON
    public init?(_ json: JSON?) {
        var x: Int?
        x <-- json
        guard let i = x else {
            return nil
        }
        self.init(i)
    }
}

extension UInt {
    /// Construct a `UInt` from JSON
    public init?(_ json: JSON?) {
        var x: UInt?
        x <-- json
        guard let u = x else {
            return nil
        }
        self.init(u)
    }
}

extension Double {
    /// Construct a `Double` from JSON
    public init?(_ json: JSON?) {
        var x: Double?
        x <-- json
        guard let d = x else {
            return nil
        }
        self.init(d)
    }
}

extension Float {
    /// Construct a `Float` from JSON
    public init?(_ json: JSON?) {
        var x: Float?
        x <-- json
        guard let f = x else {
            return nil
        }
        self.init(f)
    }
}

extension CGFloat {
    /// Construct a `CGFloat` from JSON
    public init?(_ json: JSON?) {
        var x: CGFloat?
        x <-- json
        guard let f = x else {
            return nil
        }
        self.init(f)
    }
}

extension Bool {
    /// Construct a `Bool` from JSON
    public init?(_ json: JSON?) {
        var x: Bool?
        x <-- json
        guard let b = x else {
            return nil
        }
        self.init(b)
    }
}

extension URL {
    /// Construct a `URL` from JSON
    public init?(_ json: JSON?) {
        var x: String?
        x <-- json
        guard let s = x else {
            return nil
        }
        self.init(string: s)
    }
}

// MARK: - Raw representable

extension RawRepresentable {
    /// Construct a `RawRepresentable` from JSON
    public init?(_ json: JSON?) {
        var x: Self.RawValue?
        x <-- json
        guard let r = x else {
            return nil
        }
        self.init(rawValue: r)
    }
}

// MARK: - Array of plain types

extension Array {
    /// Construct an `Array` from JSON
    public init?(_ json: JSON?) {
        var x: [Element]?
        x <-- json
        guard let a = x else {
            return nil
        }
        self.init(a)
    }
}

//extension Array where Element: RawRepresentable {
//    /// Construct an `Array` of `RawRepresentable` elements from JSON
//    public init?(_ json: JSON?) {
//        var x: [Element]?
//        x <-- json
//        guard let a = x else {
//            return nil
//        }
//        self.init(a)
//    }
//}
