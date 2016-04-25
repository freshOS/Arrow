//
//  Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public protocol ArrowParsable {
    init()
    mutating func deserialize(json:JSON)
}

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

public func <-- <T>( left: inout T, right: JSON?) {
    var temp:T? = nil
    parseType(left: &temp, right:right)
    if let t = temp {
        left = t
    }
}

// Support optional Data
public func <-- <T>( left: inout T?, right: JSON?) {
    parseType(left: &left, right: right)
}

func parseType<T>( left:inout T?,right:JSON?) {
    if let v: T = right?.data as? T {
        left = v
    } else if let s = right?.data as? String {
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

// Support Enum

public func <-- <T: RawRepresentable>( left: inout T, right: JSON?) {
    var temp: T.RawValue? = nil
    parseType(left: &temp, right:right)
    if let t = temp, let e = T.init(rawValue: t) {
        left = e
    }
}

public func <-- <T: RawRepresentable>( left: inout T?, right: JSON?) {
    var temp: T.RawValue? = nil
    parseType(left: &temp, right:right)
    if let t = temp, let e = T.init(rawValue: t) {
        left = e
    }
}

// MARK: - Parse Custom Types

public func <-- <T:ArrowParsable>( left:inout T, right: JSON?) {
    if let json = JSON(right?.data) {
        var t = T.init()
        t.deserialize(json: json)
        left = t
    }
}

public func <-- <T:ArrowParsable>( left:inout T?, right: JSON?) {
    if let json = JSON(right?.data) {
        var t = T.init()
        t.deserialize(json: json)
        left = t
    }
}

// MARK: - Array of custom Types

public func <-- <T:ArrowParsable>( left:inout [T], right: JSON?) {
    if let a = right?.data as? [AnyObject] {
        left = a.map {
            var t = T.init()
            if let json = JSON($0) {
                t.deserialize(json: json) //TODO return t even if T not parsable??
            }
            return t
        }
    }
}

public func <-- <T:ArrowParsable>( left:inout [T]?, right: JSON?) {
    if let a = right?.data as? [AnyObject] {
        left = a.map {
            var t = T.init()
            if let json = JSON($0) {
                t.deserialize(json: json) //TODO return t even if T not parsable??
            }
            return t
        }
    }
}

// MARK: - NSDate Parsing

public func <-- ( left: inout NSDate, right: JSON?) {
    var temp: NSDate? = nil
    parseDate(left: &temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- ( left: inout NSDate?, right: JSON?) {
    parseDate(left: &left, right:right)
}

func parseDate( left:inout NSDate?,right:JSON?) {
    
    // Use custom date format over high level setting when provided
    if let customFormat = right?.jsonDateFormat {
        if let s = right?.data as? String {
            let df = NSDateFormatter()
            df.dateFormat = customFormat
            left = df.date(from: s)
        }
    } else {
        if let s = right?.data as? String {
            if let date = dateFormatter.date(from: s)  {
                left = date
            } else if let t = NSTimeInterval(s) {
                left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
            }
        } else if let t = right?.data as? NSTimeInterval {
            left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
        }
    }
}

// MARK: - NSURL Parsing

public func <-- ( left: inout NSURL, right: JSON?) {
    var temp: NSURL? = nil
    parseURL(left: &temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- ( left: inout NSURL?, right: JSON?) {
    parseURL(left: &left, right: right)
}

func parseURL( left:inout NSURL?, right:JSON?) {
    var str = ""
    str <-- right
    if let url = NSURL(string:str) {
        left = url
    }
}


// MARK: - Support Array of plain Types
//TODO : No tests VAlitaing "Support Array of plain Types"

func parseArray<T>( left: inout [T]?, right: JSON?) {
    if let a = right?.data as? [AnyObject] {
        let tmp: [T] = a.flatMap { var t: T?; parseType(left: &t, right: JSON($0)); return t }
        if tmp.count == a.count {
            left = tmp
        }
    }
}

public func <-- <T>( left: inout [T], right: JSON?) {
    var temp:[T]? = nil
    parseArray(left: &temp, right:right)
    if let t = temp {
        left = t
    }
}

public func <-- <T>( left: inout [T]?, right: JSON?) {
    parseArray(left: &left, right: right)
}