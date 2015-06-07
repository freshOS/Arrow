//
//  Models.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct Stats {
    var numberOfFriends = 0
    var numberOfFans = 0
}

struct Profile {
    var identifier = 0
    var createdAt = NSDate()
    var name = ""
    var stats = Stats()
}
