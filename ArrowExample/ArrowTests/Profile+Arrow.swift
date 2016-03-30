//
//  Profile+Arrow.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import Arrow

extension Profile:ArrowParsable {
    
    init(json: JSON) {
        identifier <-- json["id"]
        createdAt <-- json["created_at"]
        name <-- json["name"]
        optionalName = nil
        optionalName <-- json["name"]
        stats <== json["stats"]
        optionalStats = nil
        optionalStats <== json["stats"]
        optionalDate = nil
        optionalDate <-- json["created_at_timestamp"]
    }
}