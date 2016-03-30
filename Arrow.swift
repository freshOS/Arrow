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
    var temp:T? = left
    parseType(&temp, right:right)
    left = temp!
}

// Support optional Data
public func <-- <T>(inout left: T?, right: AnyObject?) {
    parseType(&left, right: right)
}

func parseType<T>(inout left:T?,right:AnyObject?) {
    if let v: T = right as? T {
        left = v
    } else if let s = right as? String {
        switch T.self {
        case is Int.Type: if let v = Int(s) { left = v as? T }
        case is UInt.Type: if let v = UInt(s) { left = v as? T }
        case is Double.Type: if let v = Double(s) { left = v as? T }
        case is Float.Type: if let v = Float(s) { left = v as? T }
        case is CGFloat.Type: if let v = CGFloat.NativeType(s) { left = v as? T }
        case is Bool.Type: if let v = Int(s) { left = Bool(v) as? T}
        default:()
        }
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

// Suppport Array of custom Types

public func <== <T:ArrowParsable>(inout left:[T], right: AnyObject?) {
    left = [T]()
    if let pns = right as? [AnyObject] {
        for pn in pns {
            left.append(T(json:pn))
        }
    }
}

// MARK: - NSDate Parsing

// Override Arrow Operator to catch NSDate Mapping and apply our transformation
public func <-- (inout left: NSDate, right: AnyObject?) {
    var temp:NSDate? = left
    parseDate(&temp, right:right)
    left = temp!
}

public func <-- (inout left: NSDate?, right: AnyObject?) {
    parseDate(&left, right:right)
}

func parseDate(inout left:NSDate?,right:AnyObject?) {
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