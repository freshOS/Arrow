//
//  ArrowTests.swift
//  ArrowTests
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Arrow

struct NativeTypesTests {
    
    var profile = Profile()
    
    init() {
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = mockJSON() {
            profile <-- json
        }
    }
    
    @Test
    func pParsingInt() {
        #expect(profile.identifier == 15678)
    }

    @Test
    func parsingFloat() {
        #expect(profile.float == 0.12)
    }
    
    @Test
    func parsingCGFloat() {
        #expect(profile.cgfloat == 0.12)
    }
    
    @Test
    func parsingDouble() {
        #expect(profile.double == 0.123456789)
    }
} 

