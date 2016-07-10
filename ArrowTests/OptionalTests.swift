//
//  URLTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class OptionalTests: XCTestCase {
    
    var optionalProfile = OptionalProfile()

    override func setUp() {
        super.setUp()
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = jsonForName("Profile") {
            optionalProfile = OptionalProfile()
            optionalProfile.deserialize(json)
        }
    }
    
    func testParsingOptionalURL() {
        XCTAssertEqual(optionalProfile.optionalLink?.absoluteString
            .stringByRemovingPercentEncoding, "https://apple.com/steve")
    }
    
    func testParsingOptionalEmojiURL() {
        XCTAssertEqual(optionalProfile.optionalEmojiLink?.absoluteString
            .stringByRemovingPercentEncoding, "http://🆒🔗.ws")
    }
    
    func testParsingOptionalAccentURL() {
        XCTAssertEqual(optionalProfile.optionalAccentLink?.absoluteString
            .stringByRemovingPercentEncoding, "http://gégé.com")
    }
    
    func testParsingOptionalDate() {
        let timestamp: NSTimeInterval = 392308720
        if let d = optionalProfile.optionalDate?.timeIntervalSinceReferenceDate {
            XCTAssertEqualWithAccuracy(timestamp, d, accuracy: 0.1)
        } else {
            XCTFail()
        }
    }
    
    
    func testParsingOptionalString() {
        XCTAssertEqual(optionalProfile.optionalName, "Francky")
    }
    
    func testParsingOptionalCustomModel() {
        XCTAssertEqual(optionalProfile.optionalStats?.numberOfFriends, 163)
        XCTAssertEqual(optionalProfile.optionalStats?.numberOfFans, 10987)
    }
    
    func testParsingOptionalArrayOfCustomModels() {
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?.count, 3)
        
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?[0].label, "house")
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?[1].label, "cell")
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?[2].label, "work")
        
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?[0].number, "9809876545")
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?[1].number, "0908070656")
        XCTAssertEqual(optionalProfile.optionalPhoneNumbers?[2].number, "0916570656")
    }
    
    func testParsingOptionalEnumInt() {
        XCTAssertEqual(optionalProfile.optionalWeekday, WeekDay.Wednesday)
    }
    
    func testParsingOptionalEnumString() {
        XCTAssertEqual(optionalProfile.optionalDifficulty, Difficulty.High)
    }
}
