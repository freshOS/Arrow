//
//  Profile.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import CoreGraphics

enum WeekDay: Int {
    case Monday = 1
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

enum Difficulty: String {
    case Low
    case Medium
    case High
}

struct Profile {
    var identifier = 0
    var link = NSURL()
    var optionalLink: NSURL?
    var emojiLink = NSURL()
    var optionalEmojiLink: NSURL?
    var accentLink = NSURL()
    var optionalAccentLink: NSURL?
    var createdAt = NSDate()
    var name = ""
    var optionalName: String?
    var stats = Stats()
    var optionalStats: Stats?
    var optionalDate: NSDate?
    var phoneNumbers = [PhoneNumber]()
    var optionalPhoneNumbers: [PhoneNumber]? = nil
    var strings = [String]()
    var ints = [Int]()
    var bools = [Bool]()
    var double: Double = 0.0
    var float: CGFloat = 0.0
    var cgfloat: CGFloat = 0.0
    var doubleString: Double = 0.0
    var floatString: CGFloat = 0.0
    var cgfloatString: CGFloat = 0.0
    var weekday: WeekDay = .Monday
    var optionalWeekday: WeekDay?
    var difficulty = Difficulty.Low
    var optionalDifficulty: Difficulty?
    var meaningOfLife: Int = 0
    var nestedArrayParsing = ""
}
