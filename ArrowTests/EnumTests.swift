//
//  EnumTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class EnumTests: XCTestCase {

    var enumContainer = EnumContainer()
    
    override func setUp() {
        super.setUp()
        if let json: JSON = jsonForName("Profile") {
            enumContainer = EnumContainer()
            enumContainer.deserialize(json)
        }
    }

    func testParsingEnumInt() {
        XCTAssertEqual(enumContainer.weekday, WeekDay.Wednesday)
    }
    
    func testParsingEnumString() {
        XCTAssertEqual(enumContainer.difficulty, Difficulty.High)
    }
    
    func testParsingOptionalEnumInt() {
        XCTAssertEqual(enumContainer.optionalWeekday, WeekDay.Wednesday)
    }
    
    func testParsingOptionalEnumString() {
        XCTAssertEqual(enumContainer.optionalDifficulty, Difficulty.High)
    }
}
