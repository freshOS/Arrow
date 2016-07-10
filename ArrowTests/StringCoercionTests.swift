//
//  StringCoercionTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

struct CoercionContainer {
    var doubleString: Double = 0.0
    var floatString: Float = 0.0
    var cgfloatString: CGFloat = 0.0
}

extension CoercionContainer:ArrowParsable {
    
    mutating func deserialize(json: JSON) {
        cgfloatString <-- json["floatString"]
        floatString <-- json["floatString"]
        doubleString <-- json["doubleString"]
    }
}

class StringCoercionTests: XCTestCase {
    
    var coercionContainer = CoercionContainer()
    
    override func setUp() {
        super.setUp()
        if let json: JSON = jsonForName("Profile") {
            coercionContainer = CoercionContainer()
            coercionContainer.deserialize(json)
        }
    }
    
    func testParsingFloatString() {
        XCTAssertEqual(coercionContainer.floatString, 0.12)
    }
    
    func testParsingCGFloatString() {
        XCTAssertEqual(coercionContainer.cgfloatString, 0.12)
    }
    
    func testParsingDoubleString() {
        XCTAssertEqual(coercionContainer.doubleString, 0.123456789)
    }
}
