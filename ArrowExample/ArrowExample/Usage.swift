//
//  Usage.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

import Arrow

class Usage {

    class func show() {
        
        // Configure NSDate Parsing
        Arrow.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")

        let json:JSON = jsonForName("Profile")!
        let profile = Profile(json: json)
        print("id : \(profile.identifier)")
        print("created at : \(profile.createdAt)")
        print("name : \(profile.name)")
        print("friends : \(profile.stats.numberOfFriends)")
        print("fans : \(profile.stats.numberOfFans)")
    }
}


    func jsonForName(name: String) -> JSON? {
        let bundle = NSBundle.mainBundle()
        if let path:String = bundle.pathForResource(name, ofType: "json") {

            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary {
                    return json
                }
            } catch {

            }
        }



    //        it disappears after I change to code let sceneData = NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe) because of new error handling in swift 2.0
    //

        return nil
    }
