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
            dateContainer = DateContainer()
            dateContainer.deserialize(json)
        }
    }
    
    func testParsingDate() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let date = df.date(from: "2013-06-07T16:38:40+02:00") {
            XCTAssertEqualWithAccuracy(date.timeIntervalSinceReferenceDate, dateContainer.createdAt
                .timeIntervalSinceReferenceDate, accuracy: 0.1)
        } else {
            XCTFail()
        }
    }
    
    func testParsingOptionalDate() {
        let timestamp: TimeInterval = 392308720
        if let d = dateContainer.optionalDate?.timeIntervalSinceReferenceDate {
            XCTAssertEqualWithAccuracy(timestamp, d, accuracy: 0.1)
        } else {
            XCTFail()
        }
    }
}
