//
//  Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public typealias JSON = AnyObject

private let dateFormater = NSDateFormatter()

public class Arrow {
    public class func setDateFormat(format:String) {
        dateFormater.dateFormat = format
    }
}

// MARK : -  Parse Default swift Types

infix operator <-- {}
public func <-- <T>(inout left: T, right: AnyObject?) {
    if let v: T = right as? T {
        left = v
    }
}

// Support otional Data
public func <-- <T>(inout left: T?, right: AnyObject?) {
    if let v: T = right as? T {
        left = v
    }
}


// MARK : - Parse Custom Types

public protocol ArrowParsable {
    init(json: JSON)
}

infix operator <== {}
public func <== <T:ArrowParsable>(inout left:T, right: AnyObject?) {
    if let r: AnyObject = right {
        left = T.self(json:r)
    }
}


// MARK : - NSDate Parsing 

// Override Arrow Operator to catch NSDate Mapping and apply our transformation
public func <-- (inout left: NSDate, right: AnyObject?) {
    if let s = right as? String, let date = dateFormater.dateFromString(s)  {
        left = date
    }
}

public func <-- (inout left: NSDate?, right: AnyObject?) {
    if let s = right as? String, let date = dateFormater.dateFromString(s)  {
        left = date
    }
}

