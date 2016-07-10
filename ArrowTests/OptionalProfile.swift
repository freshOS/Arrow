//
//  OptionalProfile.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

class OptionalProfile {
    var optionalLink: NSURL?
    var optionalEmojiLink: NSURL?
    var optionalAccentLink: NSURL?
    var optionalName: String?
    var optionalStats: Stats?
    var optionalDate: NSDate?
    var optionalPhoneNumbers: [PhoneNumber]? = nil
    var optionalWeekday: WeekDay?
    var optionalDifficulty: Difficulty?
    
    required init() {}
}
