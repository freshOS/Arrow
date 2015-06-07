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
        
        // Configure NSDate Parsing
        Arrow.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")

        let json:JSON = Arrow.jsonForName("Profile")
        let profile = Profile(json: json)
        println("id : \(profile.identifier)")
        println("created at : \(profile.createdAt)")
        println("name : \(profile.name)")
        println("friends : \(profile.stats.numberOfFriends)")
        println("fans : \(profile.stats.numberOfFans)")
    }
}
