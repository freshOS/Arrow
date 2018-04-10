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
            profile <-- json
        }
    }
    
    func testParsingInt() {
        XCTAssertEqual(profile.identifier, 15678)
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
}

// Helper

func jsonForName(_ name: String) -> JSON? {
    let bundle = Bundle(for: NativeTypesTests.self)
    if let path: String = bundle.path(forResource: name, ofType: "json"),
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
        let json = try? JSONSerialization
            .jsonObject(with: jsonData,
                                options: .mutableContainers) as? NSDictionary,
        let dic = json as? [String: Any] {
            return JSON(dic)
    }
    return nil
}
