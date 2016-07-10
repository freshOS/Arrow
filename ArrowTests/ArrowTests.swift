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
    
    var profile = Profile()
    
    override func setUp() {
        super.setUp()
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = jsonForName("Profile") {
            profile = Profile()
            profile.deserialize(json)
        }
    }
    
    func testParsingInt() {
        XCTAssertEqual(profile.identifier, 15678)
    }
    
    func testParsingURL() {
        XCTAssertEqual(profile.link.absoluteString
            .stringByRemovingPercentEncoding, "https://apple.com/steve")
    }
    
    func testParsingEmojiURL() {
        XCTAssertEqual(profile.emojiLink.absoluteString
            .stringByRemovingPercentEncoding, "http://🆒🔗.ws")
    }
    
    func testParsingAccentURL() {
        XCTAssertEqual(profile.accentLink.absoluteString
            .stringByRemovingPercentEncoding, "http://gégé.com")
    }

    func testParsingDate() {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let date = df.dateFromString("2013-06-07T16:38:40+02:00") {
        XCTAssertEqualWithAccuracy(date.timeIntervalSinceReferenceDate, profile.createdAt
            .timeIntervalSinceReferenceDate, accuracy: 0.1)
        } else {
            XCTFail()
        }
    }

    func testParsingString() {
        XCTAssertEqual(profile.name, "Francky")
    }

    func testParsingCustomModel() {
        XCTAssertEqual(profile.stats.numberOfFriends, 163)
        XCTAssertEqual(profile.stats.numberOfFans, 10987)
    }

    func testParsingArrayOfCustomModels() {
        XCTAssertEqual(profile.phoneNumbers.count, 3)
        if profile.phoneNumbers.count >= 3 {
            XCTAssertEqual(profile.phoneNumbers[0].label, "house")
            XCTAssertEqual(profile.phoneNumbers[1].label, "cell")
            XCTAssertEqual(profile.phoneNumbers[2].label, "work")
            
            XCTAssertEqual(profile.phoneNumbers[0].number, "9809876545")
            XCTAssertEqual(profile.phoneNumbers[1].number, "0908070656")
            XCTAssertEqual(profile.phoneNumbers[2].number, "0916570656")
        } else {
            XCTFail()
        }
    }

    func testParsingArrayOfStrings() {
        XCTAssertEqual(profile.strings.count, 3)
        if profile.strings.count >= 3 {
            XCTAssertEqual(profile.strings[0], "one")
            XCTAssertEqual(profile.strings[1], "two")
            XCTAssertEqual(profile.strings[2], "three")
        } else {
            XCTFail()
        }
    }

    func testParsingArrayOfInts() {
        XCTAssertEqual(profile.ints.count, 3)
        if profile.ints.count >= 3 {
            XCTAssertEqual(profile.ints[0], 1)
            XCTAssertEqual(profile.ints[1], 2)
            XCTAssertEqual(profile.ints[2], 3)
        } else {
            XCTFail()
        }
    }

    func testParsingArrayOfBools() {
        XCTAssertEqual(profile.bools.count, 3)
        if profile.bools.count >= 3 {
            XCTAssertEqual(profile.bools[0], true)
            XCTAssertEqual(profile.bools[1], false)
            XCTAssertEqual(profile.bools[2], true)
        } else {
            XCTFail()
        }
    }

    func testParsingFloat() {
        XCTAssertEqual(profile.float, 0.12)
    }
    
    func testParsingCGFloat() {
        XCTAssertEqual(profile.cgfloat, 0.12)
    }
    
    func testParsingDouble() {
        XCTAssertEqual(profile.double, 0.123456789)
    }
    
    func testParsingFloatString() {
        XCTAssertEqual(profile.floatString, 0.12)
    }
    
    func testParsingCGFloatString() {
        XCTAssertEqual(profile.cgfloatString, 0.12)
    }
    
    func testParsingDoubleString() {
        XCTAssertEqual(profile.doubleString, 0.123456789)
    }
    
    func testParsingEnumInt() {
        XCTAssertEqual(profile.weekday, WeekDay.Wednesday)
    }
    
    func testParsingEnumString() {
        XCTAssertEqual(profile.difficulty, Difficulty.High)
    }
    
    func testNestedParsing() {
        XCTAssertEqual(profile.meaningOfLife, 42)
    }
    
    func testNestedArrayParsing() {
        XCTAssertEqual(profile.nestedArrayParsing, "Cool")
    }
}


// Helper

func jsonForName(name: String) -> JSON? {
    let bundle = NSBundle(forClass: ArrowTests.self)
    if let path: String = bundle.pathForResource(name, ofType: "json"),
        jsonData = try? NSData(contentsOfFile: path,
                               options:.DataReadingMappedIfSafe),
        json = try? NSJSONSerialization
            .JSONObjectWithData(jsonData,
                                options: .MutableContainers) as? NSDictionary,
        dic = json as? [String : AnyObject] {
            return JSON(dic)
    }
    return nil
}
