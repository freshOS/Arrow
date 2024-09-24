//
//  TypeConversionTests.swift
//  Arrow
//
//  Created by Max Konovalov on 07/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Foundation
import Arrow

@Suite
struct TypeConversionTests {
    
    let json: JSON? = mockJSON()
    
    @Test
    func testStringConversion() {
        #expect(String(json?["name"]) == "Francky")
    }
    
    @Test
    func testIntConversion() {
        #expect(Int(json?["id"]) == 15678)
    }
    
    @Test
    func testUIntConversion() {
        #expect(UInt(json?["id"]) == 15678)
    }
    
    @Test
    func testDoubleConversion() {
        #expect(Double(json?["double"]) == 0.123456789)
    }
    
    @Test
    func testFloatConversion() {
        #expect(Float(json?["float"]) == 0.12)
    }
    
    @Test
    func testCGFloatConversion() {
        #expect(CGFloat(json?["float"]) == 0.12)
    }
    
    @Test
    func testBoolConversion() {
        #expect(Bool(json?["bool"]) == true)
    }
    
    @Test
    func testEnumConversion() {
        #expect(WeekDay(json?["weekdayInt"]) ==  WeekDay.wednesday)
    }
    
    @Test
    func testArrayConversions() {
        #expect([String](json?["strings"]) ?? [] == ["one", "two", "three"])
    }
    
    @Test
    func testArrayEnumConversions() {
        #expect([WeekDay](json?["weekdays"]) ?? [] == [.monday, .wednesday, .friday])
    }
    
    @Test
    func testDictionaryConversions() {
        #expect([String: String](json?["dict"]) ?? [:] == ["one": "1", "two": "2"])
    }
}
