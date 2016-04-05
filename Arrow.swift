//
//  Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import CoreGraphics

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
    var temp:T? = nil
    parseType(&temp, right:right)
    if let t = temp {
        left = t
    }
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
        case is CGFloat.Type: if let v = CGFloat.NativeType(s) { left = CGFloat(v) as? T }
        case is Bool.Type: if let v = Int(s) { left = Bool(v) as? T}
        default:()
        }
    }
}

// Support Array of plain Types

func parseArray<T>(inout left: [T]?, right: AnyObject?) {
    if let a = right as? [AnyObject] {
        let tmp: [T] = a.flatMap { var t: T?; parseType(&t, right: $0); return t }
        if tmp.count == a.count {
            left = tmp
        }
    }
}

public func <-- <T>(inout left: [T], right: AnyObject?) {
    var temp:[T]? = nil
    parseArray(&temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- <T>(inout left: [T]?, right: AnyObject?) {
    parseArray(&left, right: right)
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
    if let a = right as? [AnyObject] {
        left = a.map { T(json: $0) }
    }
}

public func <== <T:ArrowParsable>(inout left:[T]?, right: AnyObject?) {
    if let a = right as? [AnyObject] {
        left = a.map { T(json: $0) }
    }
}

// MARK: - NSDate Parsing

// Override Arrow Operator to catch NSDate Mapping and apply our transformation
public func <-- (inout left: NSDate, right: AnyObject?) {
    var temp:NSDate? = left
    parseDate(&temp, right:right)
    if let t = temp {
        left = t
    }
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