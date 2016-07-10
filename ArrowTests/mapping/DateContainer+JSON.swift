//
//  DateContainer+JSON.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension DateContainer:ArrowParsable {
    
    mutating func deserialize(json: JSON) {
        createdAt <-- json["created_at"]?.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        optionalDate = nil
        optionalDate <-- json["created_at_timestamp"]
    }
}
