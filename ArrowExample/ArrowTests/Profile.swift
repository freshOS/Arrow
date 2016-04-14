//
//  Profile.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

enum WeekDay:Int {
    case Monday = 1
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

enum Difficulty:String {
    case Low
    case Medium
    case High
}

struct Profile {
    var identifier = 0
    var createdAt = NSDate()
    var name = ""
    var optionalName:String?
    var stats = Stats()
    var optionalStats:Stats?
    var optionalDate:NSDate?
    var phoneNumbers = [PhoneNumber]()
    var optionalPhoneNumbers:[PhoneNumber]? = nil
    var strings = [String]()
    var ints = [Int]()
    var bools = [Bool]()
    var double:Double = 0.0
    var float:CGFloat = 0.0
    var cgfloat:CGFloat = 0.0
    var doubleString:Double = 0.0
    var floatString:CGFloat = 0.0
    var cgfloatString:CGFloat = 0.0
    var weekday:WeekDay = .Monday
    var optionalWeekday:WeekDay?
    var difficulty = Difficulty.Low
    var optionalDifficulty:Difficulty?
}


import Arrow

extension Profile:ArrowParsable {
    
    init(json: JSON) {
        identifier <-- json["id"]
        createdAt <-- json["created_at"]
        name <-- json["name"]
        optionalName = nil
        optionalName <-- json["name"]
        stats <== json["stats"]
        optionalStats = nil
        optionalStats <== json["stats"]
        optionalDate = nil
        optionalDate <-- json["created_at_timestamp"]
        phoneNumbers <== json["phoneNumbers"]
        optionalPhoneNumbers <== json["phoneNumbers"]
        strings <-- json["strings"]
        ints <-- json["ints"]
        bools <-- json["bools"]
        cgfloat <-- json["float"]
        float <-- json["float"]
        double <-- json["double"]
        cgfloatString <-- json["floatString"]
        floatString <-- json["floatString"]
        doubleString <-- json["doubleString"]
        weekday <-- json["weekdayInt"]
        optionalWeekday <-- json["weekdayInt"]
        difficulty <-- json["difficulty"]
        optionalDifficulty <-- json["difficulty"]
    }
}