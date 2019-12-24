//
//  ArrowTests.swift
//  ArrowTests
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class NativeTypesTests: XCTestCase {
    
    var profile = Profile()
    
    override func setUp() {
        super.setUp()
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = mockJSON() {
            profile <-- json
        }
    }
    
    func testParsingInt() {
        XCTAssertEqual(profile.identifier, 15678)
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
} 

