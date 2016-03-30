//
//  ArrowTests.swift
//  ArrowTests
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import UIKit
import XCTest
import Arrow

class ArrowTests: XCTestCase {
    
    
    var profile:Profile?
    
    override func setUp() {
        super.setUp()
        Arrow.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        let json:JSON = jsonForName("Profile")!
        profile = Profile(json: json)
    }
    
    override func tearDown() {
        profile = nil
        super.tearDown()
    }
    
    func testParsingInt() {
        XCTAssertEqual(profile!.identifier, 15678)
    }
    
    func testParsingDate() {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = df.dateFromString("2013-06-07T16:38:40+02:00")!
        let timestamp: NSTimeInterval = 392308720
        XCTAssertEqualWithAccuracy(date.timeIntervalSinceReferenceDate, profile!.createdAt.timeIntervalSinceReferenceDate, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(timestamp, profile!.optionalDate!.timeIntervalSinceReferenceDate, accuracy: 0.1)
    }
    
    func testParsingString() {
        XCTAssertEqual(profile!.name, "Francky")
    }
    func testParsingOptionalString() {
        XCTAssertEqual(profile!.optionalName!, "Francky")
    }
    
    func testParsingCustomModel() {
        XCTAssertEqual(profile!.stats.numberOfFriends, 163)
        XCTAssertEqual(profile!.stats.numberOfFans, 10987)
    }
    
    func testParsingOptionalCustomModel() {
        XCTAssertEqual(profile!.optionalStats!.numberOfFriends, 163)
        XCTAssertEqual(profile!.optionalStats!.numberOfFans, 10987)
    }
}


// Helper

func jsonForName(name: String) -> JSON? {
    let bundle = NSBundle.mainBundle()
    if let path:String = bundle.pathForResource(name, ofType: "json") {
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                return json
            }
        } catch {
            // json not found
        }
    }
    return nil
}

