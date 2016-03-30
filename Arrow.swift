//
//  Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public typealias JSON = AnyObject

private let dateFormatter = NSDateFormatter()

private var useReferenceDate = false

public class Arrow {
    public class func setDateFormat(format:String) {
        dateFormatter.dateFormat = format
    }
    public class func setUseTimeIntervalSinceReferenceDate(ref:Bool) {
        useReferenceDate = ref
    }
}

// MARK: - Parse Default swift Types

infix operator <-- {}
public func <-- <T>(inout left: T, right: AnyObject?) {
    if let v: T = right as? T {
        left = v
    }
}

// Support optional Data
public func <-- <T>(inout left: T?, right: AnyObject?) {
    if let v: T = right as? T {
        left = v
    }
}

// MARK: - Parse Custom Types

public protocol ArrowParsable {
    init(json: JSON)
}

infix operator <== {}
public func <== <T:ArrowParsable>(inout left:T, right: AnyObject?) {
    if let r: AnyObject = right {
        left = T.self(json:r)
    }
}

// Support optional Data
public func <== <T:ArrowParsable>(inout left:T?, right: AnyObject?) {
    if let r: AnyObject = right {
        left = T.self(json:r)
    }
}

// MARK: - Parse Numeric Types

public func <--(inout left: Int, right: AnyObject?) {
    if let v = right as? Int {
        left = v
    } else if let s = right as? String, let v = Int(s) {
        left = v
    }
}

public func <--(inout left: Int?, right: AnyObject?) {
    if let v = right as? Int {
        left = v
    } else if let s = right as? String, let v = Int(s) {
        left = v
    }
}

public func <--(inout left: UInt, right: AnyObject?) {
    if let v = right as? UInt {
        left = v
    } else if let s = right as? String, let v = UInt(s) {
        left = v
    }
}

public func <--(inout left: UInt?, right: AnyObject?) {
    if let v = right as? UInt {
        left = v
    } else if let s = right as? String, let v = UInt(s) {
        left = v
    }
}

public func <--(inout left: Bool, right: AnyObject?) {
    if let v = right as? Bool {
        left = v
    } else if let s = right as? String, let v = Int(s) {
        left = Bool(v)
    }
}

public func <--(inout left: Bool?, right: AnyObject?) {
    if let v = right as? Bool {
        left = v
    } else if let s = right as? String, let v = Int(s) {
        left = Bool(v)
    }
}

public func <--(inout left: Double, right: AnyObject?) {
    if let v = right as? Double {
        left = v
    } else if let s = right as? String, let v = Double(s) {
        left = v
    }
}

public func <--(inout left: Double?, right: AnyObject?) {
    if let v = right as? Double {
        left = v
    } else if let s = right as? String, let v = Double(s) {
        left = v
    }
}

public func <--(inout left: Float, right: AnyObject?) {
    if let v = right as? Float {
        left = v
    } else if let s = right as? String, let v = Float(s) {
        left = v
    }
}

public func <--(inout left: Float?, right: AnyObject?) {
    if let v = right as? Float {
        left = v
    } else if let s = right as? String, let v = Float(s) {
        left = v
    }
}

public func <--(inout left: CGFloat, right: AnyObject?) {
    if let v = right as? CGFloat {
        left = v
    } else if let s = right as? String, let v = CGFloat.NativeType(s) {
        left = CGFloat(v)
    }
}

public func <--(inout left: CGFloat?, right: AnyObject?) {
    if let v = right as? CGFloat {
        left = v
    } else if let s = right as? String, let v = CGFloat.NativeType(s) {
        left = CGFloat(v)
    }
}

// MARK: - NSDate Parsing

// Override Arrow Operator to catch NSDate Mapping and apply our transformation
public func <-- (inout left: NSDate, right: AnyObject?) {
    if let s = right as? String {
        if let date = dateFormatter.dateFromString(s)  {
            left = date
        } else if let t = NSTimeInterval(s) {
            left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
        }
    } else if let t = right as? NSTimeInterval {
        left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
    }
}

public func <-- (inout left: NSDate?, right: AnyObject?) {
    if let s = right as? String {
        if let date = dateFormatter.dateFromString(s)  {
            left = date
        } else if let t = NSTimeInterval(s) {
            left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
        }
    } else if let t = right as? NSTimeInterval {
        left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
    }
}

