//
//  StringContainer+JSON.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension StringContainer:ArrowParsable {
    mutating func deserialize(_ json: JSON) {
        name <-- json["name"]
        optionalName = nil
        optionalName <-- json["name"]
    }
}
