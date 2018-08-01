//
//  Extensions.swift
//  Arrow
//
//  Created by Max Konovalov on 07/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public protocol ArrowInitializable {
    init(_ json: JSON)
}

// MARK: - Plain types

extension String: ArrowInitializable {
    /// Construct a `String` from JSON
    public init(_ json: JSON) {
        var x: String?
        x <-- json
        if let s = x {
            self.init(s)
        } else {
            self.init()
        }
    }
}

extension Int: ArrowInitializable {
    /// Construct an `Int` from JSON
    public init(_ json: JSON) {
        var x: Int?
        x <-- json
        if let i = x {
            self.init(i)
        } else {
            self.init()
        }
    }
}

extension UInt: ArrowInitializable {
    /// Construct a `UInt` from JSON
    public init(_ json: JSON) {
        var x: UInt?
        x <-- json
        if let u = x {
            self.init(u)
        } else {
            self.init()
        }
    }
}

extension Double: ArrowInitializable {
    /// Construct a `Double` from JSON
    public init(_ json: JSON) {
        var x: Double?
        x <-- json
        if let d = x {
            self.init(d)
        } else {
            self.init()
        }
    }
}

extension Float: ArrowInitializable {
    /// Construct a `Float` from JSON
    public init(_ json: JSON) {
        var x: Float?
        x <-- json
        if let f = x {
            self.init(f)
        } else {
            self.init()
        }
    }
}

extension CGFloat: ArrowInitializable {
    /// Construct a `CGFloat` from JSON
    public init(_ json: JSON) {
        var x: CGFloat?
        x <-- json
        if let f = x {
            self.init(f)
        } else {
            self.init()
        }
    }
}

extension Bool: ArrowInitializable {
    /// Construct a `Bool` from JSON
    public init(_ json: JSON) {
        var x: Bool?
        x <-- json
        if let b = x {
            self.init(b)
        } else {
            self.init()
        }
    }
}

extension URL: ArrowInitializable {
    /// Construct a `URL` from JSON
    public init(_ json: JSON) {
        var x: String?
        x <-- json
        if let x = x, URL(string: x) != nil {
            self.init(string: x)!
        } else {
            self.init(string: "https//")!
        }
    }
}

// MARK: - Raw representable

//extension RawRepresentable where RawValue: ArrowInitializable {
//    /// Construct a `RawRepresentable` from JSON
//    public init(_ json: JSON) {
//        var x: Self.RawValue?
//
//        x <-- json
//        if let r = x {
//            self.init(rawValue: r)!
//        } else {
////            self.init(rawValue: r)!
//
//            self.init(rawValue:"")
//        }
//    }
//}

// MARK: - Arrays

extension Array where Element: ArrowInitializable {
    /// Construct an `Array` from JSON
    public init(_ json: JSON) {
        var x: [Element]?
        x <-- json
        if let a = x {
            self.init(a)
        } else {
            self.init()
        }
    }
}

extension Array where Element: RawRepresentable, Element.RawValue: ArrowInitializable {
    /// Construct an `Array` from JSON
    public init(_ json: JSON) {
        var x: [Element]?
        x <-- json
        if let a = x {
            self.init(a)
        } else {
            self.init()
        }
    }
}

// MARK: - Dictionaries

extension Dictionary where Value: ArrowInitializable {
    /// Construct a `Dictionary` from JSON
    public init(_ json: JSON) {
        var x: [Key: Value]?
        x <-- json
        if let d = x {
            self.init()
            for (k, v) in d {
                self.updateValue(v, forKey: k)
            }
        } else {
            self.init()
        }
    }
}
