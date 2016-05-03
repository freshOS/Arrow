//
//  Profile+JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 13/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

//===

extension Profile: ArrowParsable
{
    mutating
    func deserialize(json: JSON)
    {
        identifier <-- json["id"]
        link <-- json["link"]
        optionalLink <-- json["link"]
        createdAt <-- json["created_at"]?.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        name <-- json["name"]
        optionalName = nil
        optionalName <-- json["name"]
        stats <-- json["stats"]
        optionalStats = nil
        optionalStats <-- json["stats"]
        optionalDate = nil
        optionalDate <-- json["created_at_timestamp"]
        phoneNumbers <-- json["phoneNumbers"]
        optionalPhoneNumbers <-- json["phoneNumbers"]
        strings <-- json["strings"]
        ints <-- json["ints"]
        bools <-- json["bools"]
        cgfloat <-- json["float"]
        float <-- json["float"]
        double <-- json["double"]
        cgfloatString <-- json["floatString"]
        floatString <-- json["floatString"]
        doubleString <-- json["doubleString"]
        weekday <-- json["weekdayInt"]
        optionalWeekday <-- json["weekdayInt"]
        difficulty <-- json["difficulty"]
        optionalDifficulty <-- json["difficulty"]
        meaningOfLife <-- json["nested.nested.nested.nestedValue"]
        nestedArrayParsing <-- json["nestedArray.2"]
    }
}