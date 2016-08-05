//
//  Stats+JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 13/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension Stats:ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        numberOfFriends <-- json["numberOfFriends"]
        numberOfFans <-- json["numberOfFans"]
    }
}
