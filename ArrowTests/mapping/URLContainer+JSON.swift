//
//  URLContainer+JSON.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension URLContainer:ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        link <-- json["link"]
        emojiLink <-- json["emoji_link"]
        accentLink <-- json["accent_link"]
        optionalLink <-- json["link"]
    }
}
