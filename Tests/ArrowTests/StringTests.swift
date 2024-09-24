//
//  StringTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Arrow

@Suite
struct StringTests {
    
    var stringContainer = StringContainer()
    
    init() {
        if let json: JSON = mockJSON() {
            stringContainer <-- json
        }
    }
    
    @Test
    func parsingString() {
        #expect(stringContainer.name == "Francky")
    }
    
    @Test
    func parsingOptionalString() {
        #expect(stringContainer.optionalName == "Francky")
    }
}
