//
//  ArrayTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Arrow

struct ArrayContainer {
    var phoneNumbers = [PhoneNumber]()
    var optionalPhoneNumbers: [PhoneNumber]?
    var strings = [String]()
    var ints = [Int]()
    var bools = [Bool]()
    var meaningOfLife: Int = 0
    var nestedArrayParsing = ""
    var weekdays = [WeekDay]()
    var optionalWeekdays: [WeekDay]?
}

extension ArrayContainer: ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        phoneNumbers <-- json["phoneNumbers"]
        optionalPhoneNumbers <-- json["phoneNumbers"]
        strings <-- json["strings"]
        ints <-- json["ints"]
        bools <-- json["bools"]
        meaningOfLife <-- json["nested.nested.nested.nestedValue"]
        nestedArrayParsing <-- json["nestedArray.2"]
        weekdays <-- json["weekdays"]
        optionalWeekdays <-- json["weekdays"]
    }
}

@Suite
struct ArrayTests {
    
    var arrayContainer = ArrayContainer()
    
    init() {
        if let json: JSON = mockJSON() {
            arrayContainer <-- json
        }
    }
    
    @Test
    func parsingArrayOfCustomModels() {
        #expect(arrayContainer.phoneNumbers.count == 3)
        if arrayContainer.phoneNumbers.count >= 3 {
            #expect(arrayContainer.phoneNumbers[0].label == "house")
            #expect(arrayContainer.phoneNumbers[1].label == "cell")
            #expect(arrayContainer.phoneNumbers[2].label == "work")
            
            #expect(arrayContainer.phoneNumbers[0].number == "9809876545")
            #expect(arrayContainer.phoneNumbers[1].number == "0908070656")
            #expect(arrayContainer.phoneNumbers[2].number == "0916570656")
        } else {
            Issue.record("Parsing ArrayOf Custom Models Fails")
        }
    }
    
    @Test
    func parsingOptionalArrayOfCustomModels() {
        #expect(arrayContainer.optionalPhoneNumbers?.count == 3)
        
        #expect(arrayContainer.optionalPhoneNumbers?[0].label == "house")
        #expect(arrayContainer.optionalPhoneNumbers?[1].label == "cell")
        #expect(arrayContainer.optionalPhoneNumbers?[2].label == "work")
        
        #expect(arrayContainer.optionalPhoneNumbers?[0].number == "9809876545")
        #expect(arrayContainer.optionalPhoneNumbers?[1].number == "0908070656")
        #expect(arrayContainer.optionalPhoneNumbers?[2].number == "0916570656")
    }
    
    @Test
    func parsingArrayOfStrings() {
        #expect(arrayContainer.strings.count ==  3)
        if arrayContainer.strings.count >= 3 {
            #expect(arrayContainer.strings[0] ==  "one")
            #expect(arrayContainer.strings[1] ==  "two")
            #expect(arrayContainer.strings[2] ==  "three")
        } else {
            Issue.record("Parsing an array of strings fails")
        }
    }
    
    @Test
    func parsingArrayOfInts() {
        #expect(arrayContainer.ints.count ==  3)
        if arrayContainer.ints.count >= 3 {
            #expect(arrayContainer.ints[0] ==  1)
            #expect(arrayContainer.ints[1] ==  2)
            #expect(arrayContainer.ints[2] ==  3)
        } else {
            Issue.record("Parsing an array of ints fails")
        }
    }
    
    @Test
    func parsingArrayOfBools() {
        #expect(arrayContainer.bools.count == 3)
        if arrayContainer.bools.count >= 3 {
            #expect(arrayContainer.bools[0] ==  true)
            #expect(arrayContainer.bools[1] ==  false)
            #expect(arrayContainer.bools[2] ==  true)
        } else {
            Issue.record("Parsing an array of bools fails")
        }
    }
    
    @Test
    func nestedParsing() {
        #expect(arrayContainer.meaningOfLife ==  42)
    }
    
    @Test
    func nestedArrayParsing() {
        #expect(arrayContainer.nestedArrayParsing ==  "Cool")
    }
    
    @Test
    func parsingArrayOfEnums() {
        #expect(arrayContainer.weekdays.count ==  3)
        if arrayContainer.weekdays.count >= 3 {
            #expect(arrayContainer.weekdays[0] ==  WeekDay.monday)
            #expect(arrayContainer.weekdays[1] ==  WeekDay.wednesday)
            #expect(arrayContainer.weekdays[2] ==  WeekDay.friday)
        } else {
            Issue.record("Parsing an array of enums fails")
        }
    }
    
    @Test
    func parsingOptionalArrayOfEnums() {
        #expect(arrayContainer.optionalWeekdays?.count ==  3)
        if let w = arrayContainer.optionalWeekdays, w.count >= 3 {
            #expect(arrayContainer.optionalWeekdays?[0] ==  WeekDay.monday)
            #expect(arrayContainer.optionalWeekdays?[1] ==  WeekDay.wednesday)
            #expect(arrayContainer.optionalWeekdays?[2] ==  WeekDay.friday)
        } else {
            Issue.record("Parsing an array of optional enums fails")
        }
    }
}
