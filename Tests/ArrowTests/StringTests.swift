//
//  StringTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class StringTests: XCTestCase {
    
    var stringContainer = StringContainer()
    
    override func setUp() {
        super.setUp()
        if let json: JSON = mockJSON() {
            stringContainer <-- json
        }
    }
    
    func testParsingString() {
        XCTAssertEqual(stringContainer.name, "Francky")
    }
    
    func testParsingOptionalString() {
        XCTAssertEqual(stringContainer.optionalName, "Francky")
    }
}
