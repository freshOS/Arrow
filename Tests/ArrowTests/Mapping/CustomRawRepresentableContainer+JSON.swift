//
//  CustomRawRepresentableContainer+JSON.swift
//  Arrow
//
//  Created by Max Konovalov on 03/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension CustomRawRepresentableContainer: ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        identifier <-- json["id"]
    }
    
}
