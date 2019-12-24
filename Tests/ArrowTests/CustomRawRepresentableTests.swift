//
//  CustomRawRepresentableTests.swift
//  Arrow
//
//  Created by Max Konovalov on 03/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class CustomRawRepresentableTests: XCTestCase {
    
    var customRawRepresentableContainer = CustomRawRepresentableContainer()
    
    override func setUp() {
        super.setUp()
        if let json: JSON = mockJSON() {
            customRawRepresentableContainer <-- json
        }
    }
    
    func testParsingCustomModel() {
        XCTAssertEqual(customRawRepresentableContainer.identifier, 15678)
        XCTAssertEqual(customRawRepresentableContainer.rawValue, "15678")
    }
    
}
