//
//  OptionalProfile+JSON.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

extension OptionalProfile:ArrowParsable {
    
    func deserialize(json: JSON) {
        optionalLink <-- json["link"]
        optionalEmojiLink <-- json["emoji_link"]
        optionalAccentLink <-- json["accent_link"]
        optionalName = nil
        optionalName <-- json["name"]
        optionalStats = nil
        optionalStats <-- json["stats"]
        optionalDate = nil
        optionalDate <-- json["created_at_timestamp"]
        optionalPhoneNumbers <-- json["phoneNumbers"]
        optionalWeekday <-- json["weekdayInt"]
        optionalDifficulty <-- json["difficulty"]
    }
}
