//
//  TypeConversionTests.swift
//  Arrow
//
//  Created by Max Konovalov on 07/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class TypeConversionTests: XCTestCase {
    
    let json: JSON? = mockJSON()
    
    func testStringConversion() {
        XCTAssertEqual(String(json?["name"]), "Francky")
    }
    
    func testIntConversion() {
        XCTAssertEqual(Int(json?["id"]), 15678)
    }
    
    func testUIntConversion() {
        XCTAssertEqual(UInt(json?["id"]), 15678)
    }
    
    func testDoubleConversion() {
        XCTAssertEqual(Double(json?["double"]), 0.123456789)
    }
    
    func testFloatConversion() {
        XCTAssertEqual(Float(json?["float"]), 0.12)
    }
    
    func testCGFloatConversion() {
        XCTAssertEqual(CGFloat(json?["float"]), 0.12)
    }
    
    func testBoolConversion() {
        XCTAssertEqual(Bool(json?["bool"]), true)
    }
    
    func testEnumConversion() {
        XCTAssertEqual(WeekDay(json?["weekdayInt"]), WeekDay.wednesday)
    }
    
    func testArrayConversions() {
        XCTAssertEqual([String](json?["strings"]) ?? [], ["one", "two", "three"])
    }
    
    func testArrayEnumConversions() {
        XCTAssertEqual([WeekDay](json?["weekdays"]) ?? [], [.monday, .wednesday, .friday])
    }
    
    func testDictionaryConversions() {
        XCTAssertEqual([String: String](json?["dict"]) ?? [:], ["one": "1", "two": "2"])
    }
    
}
