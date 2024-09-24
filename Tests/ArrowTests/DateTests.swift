//
//  DateTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Foundation
import Arrow

@Suite
struct DateTests {
    
    var dateContainer = DateContainer()
    
    init() {
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = mockJSON() {
            dateContainer <-- json
        }
    }
    
    @Test
    func testParsingDate() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let date = df.date(from: "2013-06-07T16:38:40+02:00") {
            #expect(date.timeIntervalSinceReferenceDate == dateContainer.createdAt.timeIntervalSinceReferenceDate)
        } else {
            Issue.record("Parsing a date fails")
        }
    }
    
    @Test
    func testParsingOptionalDate() {
        let timestamp: TimeInterval = 392308720
        if let d = dateContainer.optionalDate?.timeIntervalSinceReferenceDate {
            #expect(timestamp == d)
        } else {
            Issue.record("Parsing an Optional Date fails")
        }
    }
    
    @Test
    func testCustomDateFormatterDate() {
        if let json: JSON = mockJSON() {
            var aDate = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            df.timeZone = TimeZone(secondsFromGMT: 60*60*5)
            aDate <-- json["created_at"]?.dateFormatter(df)
            #expect(aDate == df.date(from: "2013-06-07T16:38:40+02:00"))
        } else {
            Issue.record("Using a custom date Parser fails")
        }
    }
    
    @Test
    func testGlobalDateFormatterDate() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        Arrow.setDateFormatter(df)
        if let json: JSON = mockJSON() {
            var aDate = Date()
            aDate <-- json["created_at"]
            #expect(aDate == df.date(from: "2013-06-07T16:38:40+02:00"))
        } else {
            Issue.record("Using a global date parser fails")
        }
        
        Arrow.setDateFormatter(nil)
    }
}
