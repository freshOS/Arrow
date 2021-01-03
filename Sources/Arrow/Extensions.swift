//
//  Extensions.swift
//  Arrow
//
//  Created by Max Konovalov on 07/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public protocol ArrowInitializable {
    init?(_ json: JSON?)
}

// MARK: - Plain types

extension String: ArrowInitializable {
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

extension Int: ArrowInitializable {
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

extension UInt: ArrowInitializable {
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

extension Double: ArrowInitializable {
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

extension Float: ArrowInitializable {
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

extension CGFloat: ArrowInitializable {
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

extension Bool: ArrowInitializable {
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

extension URL: ArrowInitializable {
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

extension RawRepresentable where RawValue: ArrowInitializable {
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

// MARK: - Arrays

extension Array where Element: ArrowInitializable {
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

extension Array where Element: RawRepresentable, Element.RawValue: ArrowInitializable {
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

// MARK: - Dictionaries

extension Dictionary where Value: ArrowInitializable {
    /// Construct a `Dictionary` from JSON
    public init?(_ json: JSON?) {
        var x: [Key: Value]?
        x <-- json
        guard let d = x else {
            return nil
        }
        self.init()
        for (k, v) in d {
            self.updateValue(v, forKey: k)
        }
    }
}
