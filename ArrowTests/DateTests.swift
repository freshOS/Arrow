//
//  DateTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class DateTests: XCTestCase {
    
    var dateContainer = DateContainer()
    
    override func setUp() {
        super.setUp()
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = jsonForName("Profile") {
            dateContainer <-- json
        }
    }
    
    func testParsingDate() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let date = df.date(from: "2013-06-07T16:38:40+02:00") {
            XCTAssertEqual(date.timeIntervalSinceReferenceDate, dateContainer.createdAt
                .timeIntervalSinceReferenceDate, accuracy: 0.1)
        } else {
            XCTFail("Parsing a date fails")
        }
    }
    
    func testParsingOptionalDate() {
        let timestamp: TimeInterval = 392308720
        if let d = dateContainer.optionalDate?.timeIntervalSinceReferenceDate {
            XCTAssertEqual(timestamp, d, accuracy: 0.1)
        } else {
            XCTFail("Parsing an Optional Date fails")
        }
    }
    
    func testCustomDateFormatterDate() {
        if let json: JSON = jsonForName("Profile") {
            var aDate = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            df.timeZone = TimeZone(secondsFromGMT: 60*60*5)
            aDate <-- json["created_at"]?.dateFormatter(df)
            XCTAssertEqual(aDate, df.date(from: "2013-06-07T16:38:40+02:00"))
        } else {
            XCTFail("Using a custom date Parser fails")
        }
    }
    
    func testGlobalDateFormatterDate() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        Arrow.setDateFormatter(df)
        if let json: JSON = jsonForName("Profile") {
            var aDate = Date()
            aDate <-- json["created_at"]
            XCTAssertEqual(aDate, df.date(from: "2013-06-07T16:38:40+02:00"))
        } else {
            XCTFail("Using a global date parser fails")
        }
        
        Arrow.setDateFormatter(nil)
    }
}
