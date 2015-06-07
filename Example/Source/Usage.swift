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
        let json:JSON = Arrow.jsonForName("Profile")
        let profile = Profile(json: json)
        println("id : \(profile.identifier)")
        println("created at : \(profile.createdAt)")
        println("name : \(profile.name)")
        println("friends : \(profile.stats.numberOfFriends)")
        println("fans : \(profile.stats.numberOfFans)")
    }
}

///

//
//extension Profile:ArrowParsable {
//    init(json: JSON) {
//        identifier <-- json["id"]
//        name <-- json["name"]
//        // Can use . syntax
//        //        stats.numberOfFriends <-- json.valueForKeyPath("stats.numberOfFriends")
//        //        stats.numberOfFans <-- json.valueForKeyPath("stats.numberOfFans")
//        //
//        // But even better to refacto in sub objects \o/
//        stats <== json["stats"]
//    }
//}


//TLDR:
//copy paste Arow.swift (no need for podSpec/carthage its only one file

//create a file MyModel + ArrowParsable {
//    //extension Profile:ArrowParsable {
//    init(json: JSON) {
//        identifier <-- json["id"]
//        name <-- json["name"]
//        // Can use . syntax
//        //        stats.numberOfFriends <-- json.valueForKeyPath("stats.numberOfFriends")
//        //        stats.numberOfFans <-- json.valueForKeyPath("stats.numberOfFans")
//        //
//        // But even better to refacto in sub objects \o/
//        stats <== json["stats"]
//    }
//}
//}

//3. let myModel = MyModel(json: json)
//$. there is no step 4