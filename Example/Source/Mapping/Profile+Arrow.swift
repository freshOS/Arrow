//
//  Profile+Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

extension Profile:ArrowParsable {
    
    init(json: JSON) {
        identifier <-- json["id"]
        createdAt <-- json["created_at"]
        name <-- json["name"]
        
        // Can use . syntax
//        stats.numberOfFriends <-- json.valueForKeyPath("stats.numberOfFriends")
//        stats.numberOfFans <-- json.valueForKeyPath("stats.numberOfFans")
        // But even better to refacto in sub objects \o/
        stats <== json["stats"]
    }
}