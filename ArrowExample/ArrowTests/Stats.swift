//
//  Stats.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct Stats {
    var numberOfFriends = 0
    var numberOfFans = 0
}


import Arrow

extension Stats:ArrowParsable {
    
    init(json: JSON) {
        numberOfFriends <-- json["numberOfFriends"]
        numberOfFans <-- json["numberOfFans"]
    }
}