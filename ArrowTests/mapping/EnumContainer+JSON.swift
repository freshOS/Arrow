//
//  EnumContainer+JSON.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension EnumContainer:ArrowParsable {
    
    mutating func deserialize(json: JSON) {
        weekday <-- json["weekdayInt"]
        difficulty <-- json["difficulty"]
        optionalWeekday <-- json["weekdayInt"]
        optionalDifficulty <-- json["difficulty"]
    }
}
