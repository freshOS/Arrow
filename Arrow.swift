////
////  Arrow.swift
////  Swift Structs Test
////
////  Created by Sacha Durand Saint Omer on 6/7/15.
////  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
////
//
import Foundation

//// extensibile
//
//// Arrow really shine when used in conjucction with custon parsing
//
//
//

typealias JSON = AnyObject


// Next
// share parsing logic between structs
// STAY SIMPLE - >explain simply how it works
//

//shwo  easy to extend (without modifying) -> typicla example is NSDate


class Arrow {
    class func jsonForName(name: String) -> JSON {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(name, ofType: "json")
        let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)!
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        return json
    }
}

// Parse Default swift Types
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

// Parse Custom Types
infix operator <== {}
func <== <T:ArrowParsable>(inout left:T, right: AnyObject?) {
    if let r: AnyObject = right {
        left = T.self(json:r)
    }
}

protocol ArrowParsable {
    init(json: JSON)
}


