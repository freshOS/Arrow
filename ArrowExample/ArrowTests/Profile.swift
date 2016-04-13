//
//  Profile.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import CoreGraphics

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
}