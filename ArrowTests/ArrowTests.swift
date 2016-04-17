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
//        Arrow.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        let json:JSON = jsonForName("Profile")!
        profile = Profile()
        profile?.deserialize(json)
        
    }

    override func tearDown() {
        profile = nil
        super.tearDown()
    }
    
    func testParsingInt() {
        XCTAssertEqual(profile!.identifier, 15678)
    }
    
    func testParsingURL() {
        XCTAssertEqual(profile!.link.absoluteString, "https://apple.com/steve")
    }
    
    func testParsingOptionalURL() {
        XCTAssertEqual(profile!.optionalLink!.absoluteString, "https://apple.com/steve")
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

    func testParsingArrayOfCustomModels() {
        XCTAssertEqual(profile!.phoneNumbers.count, 3)
        
        XCTAssertEqual(profile!.phoneNumbers[0].label, "house")
        XCTAssertEqual(profile!.phoneNumbers[1].label, "cell")
        XCTAssertEqual(profile!.phoneNumbers[2].label, "work")
        
        XCTAssertEqual(profile!.phoneNumbers[0].number, "9809876545")
        XCTAssertEqual(profile!.phoneNumbers[1].number, "0908070656")
        XCTAssertEqual(profile!.phoneNumbers[2].number, "0916570656")
    }

    func testParsingOptionalArrayOfCustomModels() {
        XCTAssertEqual(profile!.optionalPhoneNumbers!.count, 3)
        
        XCTAssertEqual(profile!.optionalPhoneNumbers![0].label, "house")
        XCTAssertEqual(profile!.optionalPhoneNumbers![1].label, "cell")
        XCTAssertEqual(profile!.optionalPhoneNumbers![2].label, "work")
        
        XCTAssertEqual(profile!.optionalPhoneNumbers![0].number, "9809876545")
        XCTAssertEqual(profile!.optionalPhoneNumbers![1].number, "0908070656")
        XCTAssertEqual(profile!.optionalPhoneNumbers![2].number, "0916570656")
    }

    func testParsingArrayOfStrings() {
        XCTAssertEqual(profile!.strings.count, 3)
        XCTAssertEqual(profile!.strings[0], "one")
        XCTAssertEqual(profile!.strings[1], "two")
        XCTAssertEqual(profile!.strings[2], "three")
    }

    func testParsingArrayOfInts() {
        XCTAssertEqual(profile!.ints.count, 3)
        XCTAssertEqual(profile!.ints[0], 1)
        XCTAssertEqual(profile!.ints[1], 2)
        XCTAssertEqual(profile!.ints[2], 3)
    }

    func testParsingArrayOfBools() {
        XCTAssertEqual(profile!.bools.count, 3)
        XCTAssertEqual(profile!.bools[0], true)
        XCTAssertEqual(profile!.bools[1], false)
        XCTAssertEqual(profile!.bools[2], true)
    }

    func testParsingFloat() {
        XCTAssertEqual(profile!.float, 0.12)
    }
    
    func testParsingCGFloat() {
        XCTAssertEqual(profile!.cgfloat, 0.12)
    }
    
    func testParsingDouble() {
        XCTAssertEqual(profile!.double, 0.123456789)
    }
    
    func testParsingFloatString() {
        XCTAssertEqual(profile!.floatString, 0.12)
    }
    
    func testParsingCGFloatString() {
        XCTAssertEqual(profile!.cgfloatString, 0.12)
    }
    
    func testParsingDoubleString() {
        XCTAssertEqual(profile!.doubleString, 0.123456789)
    }
    
    func testParsingEnumInt() {
        XCTAssertEqual(profile!.weekday, WeekDay.Wednesday)
    }
    
    func testParsingOptionalEnumInt() {
        XCTAssertEqual(profile!.optionalWeekday, WeekDay.Wednesday)
    }
    
    func testParsingEnumString() {
        XCTAssertEqual(profile!.difficulty, Difficulty.High)
    }
    
    func testParsingOptionalEnumString() {
        XCTAssertEqual(profile!.optionalDifficulty, Difficulty.High)
    }
    
    func testNestedParsing() {
        XCTAssertEqual(profile?.meaningOfLife, 42)
    }
}


// Helper

func jsonForName(name: String) -> JSON? {
    let bundle = NSBundle(forClass: ArrowTests.self)
    if let path:String = bundle.pathForResource(name, ofType: "json") {
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                return JSON(json as! [String : AnyObject])
            }
        } catch {
            // json not found
        }
    }
    return nil
}

