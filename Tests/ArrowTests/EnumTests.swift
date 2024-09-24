//
//  EnumTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Arrow

@Suite
struct EnumTests {

    var enumContainer = EnumContainer()
    
    init() {
        if let json: JSON = mockJSON() {
            enumContainer <-- json
        }
    }

    @Test
    func parsingEnumInt() {
        #expect(enumContainer.weekday == WeekDay.wednesday)
    }
    
    @Test
    func parsingEnumString() {
        #expect(enumContainer.difficulty == Difficulty.high)
    }
    
    @Test
    func parsingOptionalEnumInt() {
        #expect(enumContainer.optionalWeekday == WeekDay.wednesday)
    }
    
    @Test
    func parsingOptionalEnumString() {
        #expect(enumContainer.optionalDifficulty == Difficulty.high)
    }
}
