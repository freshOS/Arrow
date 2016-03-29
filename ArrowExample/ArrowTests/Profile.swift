//
//  Profile.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct Profile {
    var identifier = 0
    var createdAt = NSDate()
    var name = ""
    var optionalName:String?
    var stats = Stats()
    var optionalStats:Stats?
}
