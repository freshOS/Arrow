//
//  ArrowTests.swift
//  ArrowTests
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import UIKit
import XCTest
import Arrow

class NativeTypesTests: XCTestCase {
    
    var profile = Profile()
    
    override func setUp() {
        super.setUp()
        Arrow.setUseTimeIntervalSinceReferenceDate(true)
        if let json: JSON = jsonForName("Profile") {
            profile = Profile()
            profile.deserialize(json)
        }
    }
    
    func testParsingInt() {
        XCTAssertEqual(profile.identifier, 15678)
    }

    func testParsingString() {
        XCTAssertEqual(profile.name, "Francky")
    }
    
    func testParsingOptionalString() {
        XCTAssertEqual(profile.optionalName, "Francky")
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
    
    func testParsingFloatString() {
        XCTAssertEqual(profile.floatString, 0.12)
    }
    
    func testParsingCGFloatString() {
        XCTAssertEqual(profile.cgfloatString, 0.12)
    }
    
    func testParsingDoubleString() {
        XCTAssertEqual(profile.doubleString, 0.123456789)
    }
}


// Helper

func jsonForName(name: String) -> JSON? {
    let bundle = NSBundle(forClass: NativeTypesTests.self)
    if let path: String = bundle.pathForResource(name, ofType: "json"),
        jsonData = try? NSData(contentsOfFile: path,
                               options:.DataReadingMappedIfSafe),
        json = try? NSJSONSerialization
            .JSONObjectWithData(jsonData,
                                options: .MutableContainers) as? NSDictionary,
        dic = json as? [String : AnyObject] {
            return JSON(dic)
    }
    return nil
}
