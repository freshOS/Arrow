//
//  Profile+JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 13/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension Profile:ArrowParsable {
    
    mutating func deserialize(json: JSON) {
        identifier <-- json["id"]
        cgfloat <-- json["float"]
        float <-- json["float"]
        double <-- json["double"]
    }
}
