//
//  Profile+Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
import Arrow

extension Profile:ArrowParsable {
    
    init(json: JSON) {
        identifier <-- json["id"]
        createdAt <-- json["created_at"]
        name <-- json["name"]
        stats <== json["stats"]
    }
}