//
//  StringCoercionTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Foundation
import Arrow

struct CoercionContainer {
    var doubleString: Double = 0.0
    var floatString: Float = 0.0
    var cgfloatString: CGFloat = 0.0
}

extension CoercionContainer: ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        cgfloatString <-- json["floatString"]
        floatString <-- json["floatString"]
        doubleString <-- json["doubleString"]
    }
}

@Suite
struct StringCoercionTests {
    
    var coercionContainer = CoercionContainer()
    
    init() {
        if let json: JSON = mockJSON() {
            coercionContainer <-- json
        }
    }
    
    @Test
    func testParsingFloatString() {
        #expect(coercionContainer.floatString == 0.12)
    }
    
    @Test
    func testParsingCGFloatString() {
        #expect(coercionContainer.cgfloatString == 0.12)
    }
    
    @Test
    func testParsingDoubleString() {
        #expect(coercionContainer.doubleString == 0.123456789)
    }
}
