//
//  Profile.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct Profile {
    var identifier = 0
    var createdAt = NSDate()
    var name = ""
    var optionalName:String?
    var stats = Stats()
    var optionalStats:Stats?
    var optionalDate:NSDate?
    var phoneNumbers:[PhoneNumber] = [PhoneNumber]()
}


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
        phoneNumbers <== json["phoneNumbers"]
    }
}