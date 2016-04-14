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
    init()
    mutating func deserialize(json:JSON)
}

infix operator <== {}
public func <== <T:ArrowParsable>(inout left:T, right: AnyObject?) {
    if let r: AnyObject = right {
        var t = T.init()
        t.deserialize(r)
        left = t
    }
}

// Support optional Data
public func <== <T:ArrowParsable>(inout left:T?, right: AnyObject?) {
    if let r: AnyObject = right {
        var t = T.init()
        t.deserialize(r)
        left = t
    }
}

// Suppport Array of custom Types

public func <== <T:ArrowParsable>(inout left:[T], right: AnyObject?) {
    if let a = right as? [AnyObject] {
        left = a.map {
            var t = T.init()
            t.deserialize($0)
            return t
        }
    }
}

public func <== <T:ArrowParsable>(inout left:[T]?, right: AnyObject?) {
    if let a = right as? [AnyObject] {
        left = a.map {
            var t = T.init()
            t.deserialize($0)
            return t
        }
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

// MARK: - NSURL Parsing

public func <-- (inout left: NSURL, right: AnyObject?) {
    var temp:NSURL? = left
    parseURL(&temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- (inout left: NSURL?, right: AnyObject?) {
    parseURL(&left, right: right)
}

func parseURL(inout left:NSURL?, right:AnyObject?) {
    var str = ""
    str <-- right
    if let url = NSURL(string:str) {
        left = url
    }
}

// MARK: - Enums Parsing (Int)

public func <-- <T:RawRepresentable where T.RawValue == Int>(inout left:T , right: AnyObject?) {
    var temp:T? = left
    parseEnumInt(&temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- <T:RawRepresentable where T.RawValue == Int>(inout left:T? , right: AnyObject?) {
    parseEnumInt(&left, right:right)
}

func parseEnumInt<T:RawRepresentable where T.RawValue == Int>(inout left:T?,right:AnyObject?) {
    var id: Int = 0
    id <-- right
    if let t = T(rawValue: id) {
        left = t
    }
}

// MARK: - Enums Parsing (String)

public func <-- <T:RawRepresentable where T.RawValue == String>(inout left:T , right: AnyObject?) {
    var temp:T? = left
    parseEnumString(&temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- <T:RawRepresentable where T.RawValue == String>(inout left:T? , right: AnyObject?) {
    parseEnumString(&left, right:right)
}

func parseEnumString<T:RawRepresentable where T.RawValue == String>(inout left:T?,right:AnyObject?) {
    var str: String = ""
    str <-- right
    if let t = T(rawValue: str) {
        left = t
    }
}