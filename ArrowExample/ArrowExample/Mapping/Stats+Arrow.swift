//
//  Stats+Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import Arrow

extension Stats:ArrowParsable {
    
    init(json: JSON) {
        numberOfFriends <-- json["numberOfFriends"]
        numberOfFans <-- json["numberOfFans"]
    }
}