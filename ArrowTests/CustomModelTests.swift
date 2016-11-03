//
//  CustomModelTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class CustomModelTests: XCTestCase {
    
    var customModelContainer = CustomModelContainer()

    override func setUp() {
        super.setUp()
        if let json: JSON = jsonForName("Profile") {
            customModelContainer <-- json
        }
    }
    
    func testParsingCustomModel() {
        XCTAssertEqual(customModelContainer.stats.numberOfFriends, 163)
        XCTAssertEqual(customModelContainer.stats.numberOfFans, 10987)
    }
    
    func testParsingOptionalCustomModel() {
        XCTAssertEqual(customModelContainer.optionalStats?.numberOfFriends, 163)
        XCTAssertEqual(customModelContainer.optionalStats?.numberOfFans, 10987)
    }

}
