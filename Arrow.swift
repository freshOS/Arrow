////
////  Arrow.swift
////  Swift Structs Test
////
////  Created by Sacha Durand Saint Omer on 6/7/15.
////  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
////

import Foundation

typealias JSON = AnyObject

class Arrow {
    
    class func dateFormat(format:String) {
        ArrowDateFormatter.sharedInstance.dateFormat = format
    }
    
    class func locale(locale:NSLocale) {
        ArrowDateFormatter.sharedInstance.locale = locale
    }
    
    class func jsonForName(name: String) -> JSON {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(name, ofType: "json")
        let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)!
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        return json
    }
}

// MARK : -  Parse Default swift Types

infix operator <-- {}
func <-- <T>(inout left: T, right: AnyObject?) {
    if let v: T = right as? T {
        left = v
    }
}

// Support otional Data
func <-- <T>(inout left: T?, right: AnyObject?) {
    if let v: T = right as? T {
        left = v
    }
}


// MARK : - Parse Custom Types

protocol ArrowParsable {
    init(json: JSON)
}

infix operator <== {}
func <== <T:ArrowParsable>(inout left:T, right: AnyObject?) {
    if let r: AnyObject = right {
        left = T.self(json:r)
    }
}


// MARK : - NSDate Parsing 

// Override Arrow Operator to catch NSDate Mapping and apply our transformation
func <-- (inout left: NSDate, right: AnyObject?) {
    if let s = right as? String, let date = ArrowDateFormatter.sharedInstance.dateFromString(s)  {
        left = date
    }
}
func <-- (inout left: NSDate?, right: AnyObject?) {
    if let s = right as? String, let date = ArrowDateFormatter.sharedInstance.dateFromString(s)  {
        left = date
    }
}

// Here we use a singleton for performance purposes as
// Creating a brand new DateFormatter everytime is time costly
class ArrowDateFormatter {
    static let sharedInstance = NSDateFormatter()
}



