//
//  Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 This is the protocol that makes your swift Models JSON parsable.
 
 A typical implementation would be the following, preferably in an extension
 called `MyModel+JSON` to keep things nice and clean :
 
        //  MyModel+JSON.swift

        import Arrow

        extension MyModel: ArrowParsable {

            mutating func deserialize(json: JSON) {
                myVariable <-- json["jsonProperty"]
                //...
            }
        }
 */
public protocol ArrowParsable {
    /// Makes sur your models can be constructed with an empty constructor.
    init()
    /// The method you declare your json mapping in.
    mutating func deserialize(_ json: JSON)
}

private let dateFormatter = DateFormatter()
private var useReferenceDate = false

/**
 This is used to configure NSDate parsing on a global scale.
 
        Arrow.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        // or
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
 
 
For more fine grained control, use `dateFormat` on a per field basis :
 
        createdAt <-- json["created_at"]?.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
 */
public class Arrow {
    /// Sets the defaut dateFormat for parsing NSDates.
    public class func setDateFormat(_ format: String) {
        dateFormatter.dateFormat = format
    }
    
    /**
     Sets `timeIntervalSinceReferenceDate` parsing as the default for NSDates parsing.
     
     Default is `false`
     
     For more information see `NSDate(timeIntervalSinceReferenceDate`
     documentation
     */
    public class func setUseTimeIntervalSinceReferenceDate(_ ref: Bool) {
        useReferenceDate = ref
    }
}

// MARK: - Parse Default swift Types

infix operator <--


/// Parses default swift types.
public func <-- <T>(left: inout T, right: JSON?) {
    var temp: T? = nil
    parseType(&temp, right:right)
    if let t = temp {
        left = t
    }
}

/// Parses optional default swift types.
public func <-- <T>(left: inout T?, right: JSON?) {
    parseType(&left, right: right)
}

/// Parses enums.
public func <-- <T: RawRepresentable>(left: inout T, right: JSON?) {
    var temp: T.RawValue? = nil
    parseType(&temp, right:right)
    if let t = temp, let e = T.init(rawValue: t) {
        left = e
    }
}

/// Parses optional enums.
public func <-- <T: RawRepresentable>(left: inout T?, right: JSON?) {
    var temp: T.RawValue? = nil
    parseType(&temp, right:right)
    if let t = temp, let e = T.init(rawValue: t) {
        left = e
    }
}

/// Parses Array of enums.
public func <-- <T: RawRepresentable>(inout left: [T], right: JSON?) {
    if let array = right?.data as? [T.RawValue] {
        left = array.map { T.init(rawValue: $0) }.flatMap {$0}
    }
}

/// Parses Optional Array of enums.
public func <-- <T: RawRepresentable>(inout left: [T]?, right: JSON?) {
    if let array = right?.data as? [T.RawValue] {
        left = array.map { T.init(rawValue: $0) }.flatMap {$0}
    }
}

/// Parses user defined custom types.
public func <-- <T: ArrowParsable>(left: inout T, right: JSON?) {
    var temp: T? = nil
    parseUserDefinedType(&temp, right: right)
    if let t = temp {
        left = t
    }
}

/// Parses user defined optional custom types.
public func <-- <T: ArrowParsable>(left: inout T?, right: JSON?) {
    parseUserDefinedType(&left, right: right)
}

/// Parses arrays of user defined custom types.
public func <-- <T: ArrowParsable>(left: inout [T], right: JSON?) {
    var temp: [T]? = nil
    parseArrayOfUserDefinedTypes(&temp, right: right)
    if let t = temp {
        left = t
    }
}

/// Parses optional arrays of user defined custom types.
public func <-- <T: ArrowParsable>(left: inout [T]?, right: JSON?) {
    parseArrayOfUserDefinedTypes(&left, right: right)
}

/// Parses NSDates.
public func <-- (left: inout Date, right: JSON?) {
    var temp: Date? = nil
    parseDate(&temp, right:right)
    if let t = temp {
        left = t
    }
}

/// Parses optional NSDates.
public func <-- (left: inout Date?, right: JSON?) {
    parseDate(&left, right:right)
}

/// Parses NSURLs.
public func <-- (left: inout URL, right: JSON?) {
    var temp: URL? = nil
    parseURL(&temp, right:right)
    if let t = temp {
        left = t
    }
}

/// Parses optional NSURLs.
public func <-- (left: inout URL?, right: JSON?) {
    parseURL(&left, right: right)
}

/// Parses arrays of plain swift types.
public func <-- <T>(left: inout [T], right: JSON?) {
    var temp: [T]? = nil
    parseArray(&temp, right:right)
    if let t = temp {
        left = t
    }
}

/// Parses optional arrays of plain swift types.
public func <-- <T>(left: inout [T]?, right: JSON?) {
    parseArray(&left, right: right)
}


// MARK: - Private methods.

func parseType<T>(_ left: inout T?, right: JSON?) {
    if let v: T = right?.data as? T {
        left = v
    } else if let s = right?.data as? String {
        parseString(&left, string:s)
    }
}

func parseString<T>(_ left: inout T?, string: String) {
    switch T.self {
    case is Int.Type: if let v = Int(string) { left = v as? T }
    case is UInt.Type: if let v = UInt(string) { left = v as? T }
    case is Double.Type: if let v = Double(string) { left = v as? T }
    case is Float.Type: if let v = Float(string) { left = v as? T }
    case is CGFloat.Type: if let v = CGFloat.NativeType(string) { left = CGFloat(v) as? T }
    case is Bool.Type: if let v = Int(string) { left = Bool(v != 0)  as? T}
    default:()
    }
}

func parseURL(_ left: inout URL?, right: JSON?) {
    var str = ""
    str <-- right
    let set = CharacterSet.urlQueryAllowed
    if let escapedStr = str.addingPercentEncoding(withAllowedCharacters: set),
        let url = URL(string:escapedStr) {
        left = url
    }
}

func parseDate(_ left: inout Date?, right: JSON?) {
    // Use custom date format over high level setting when provided
    if let customFormat = right?.jsonDateFormat, let s = right?.data as? String {
        let df = DateFormatter()
        df.dateFormat = customFormat
        left = df.date(from: s)
    } else if let s = right?.data as? String {
        if let date = dateFormatter.date(from: s) {
            left = date
        } else if let t = TimeInterval(s) {
            left = timeIntervalToDate(t)
        }
    } else if let t = right?.data as? TimeInterval {
        left = timeIntervalToDate(t)
    }
}

func timeIntervalToDate(_ timeInterval: TimeInterval) -> Date {
    return useReferenceDate
    ? Date(timeIntervalSinceReferenceDate: timeInterval)
    : Date(timeIntervalSince1970: timeInterval)
}

func parseArray<T>(_ left: inout [T]?, right: JSON?) {
    if let a = right?.data as? [AnyObject] {
        let tmp: [T] = a.flatMap { var t: T?; parseType(&t, right: JSON($0)); return t }
        if tmp.count == a.count {
            left = tmp
        }
    }
}

func parseUserDefinedType<T: ArrowParsable>(_ left: inout T?, right: JSON?) {
    if let json = JSON(right?.data) {
        var t = T.init()
        t.deserialize(json)
        left = t
    }
}

func parseArrayOfUserDefinedTypes<T: ArrowParsable>(_ left: inout [T]?, right: JSON?) {
    if let a = right?.data as? [AnyObject] {
        left = a.map {
            var t = T.init()
            if let json = JSON($0) {
                t.deserialize(json)
            }
            return t
        }
    }
}
