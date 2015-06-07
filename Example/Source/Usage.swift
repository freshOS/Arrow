//
//  Usage.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

class Usage {
    class func run() {
        let json:JSON = Arrow.jsonForName("Pet")
        let profile = Profile(json: json)
        println("id : \(profile.identifier)")
        println("name : \(profile.name)")
        println("friends : \(profile.stats.numberOfFriends)")
        println("fans : \(profile.stats.numberOfFans)")
    }
}