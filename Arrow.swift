////
////  Arrow.swift
////  Swift Structs Test
////
////  Created by Sacha Durand Saint Omer on 6/7/15.
////  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
////
//
import Foundation

//
//// Pb with json parsing  :
////WE dont want our parrse immplementation details to "leak into" our models
////(ex dont hahve tu subclass a specifi class ets)
//
////Uses struct good swift citizen
//
//// Arrow json parsing
//
//// Arrow is DEAD Simple.
//// it just transforms "this :
//
////    if let id = json["id"] as? Int {
////        identifier = id
////    }
//// into this
////    identifier <-- id
//
//// The power of it is tht you can easily use other mappings with <== -> show
//
//
//// extensibile
//
//// Arrow really shine when used in conjucction with custon parsing
//
//
//

typealias JSON = AnyObject//[String:AnyObject]

// Next

// share parsing logic between structs
// STAY SIMPLE - >explain simply how it works
//


//Arrow json helper json from textFile

//shwo  easy to extend (without modifying) -> typicla example is NSDate

// Use Constructor instead of resourceFormJSON

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


