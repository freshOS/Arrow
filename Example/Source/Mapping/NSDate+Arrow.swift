//
//  NSDate+Arrow.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

// Override Arrow Operator to catch NSDate Mapping and apply our transformation

func <-- (inout left: NSDate, right: AnyObject?) {
    if let s = right as? String, let date = MyDateFormatter.sharedInstance.dateFromString(s)  {
        left = date
    }
}
func <-- (inout left: NSDate?, right: AnyObject?) {
    if let s = right as? String, let date = MyDateFormatter.sharedInstance.dateFromString(s)  {
        left = date
    }
}


// Here we use a singleton for performance purposes as
// Creating a brand new DateFormatter everytime is time costly
class MyDateFormatter {
    
    struct Unique {
        static let instance:NSDateFormatter = {
            var df = NSDateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            df.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            return df
        }()
    }
    
    class var sharedInstance:NSDateFormatter {
        return Unique.instance
    }
}
