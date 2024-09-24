//
//  CustomRawRepresentableTests.swift
//  Arrow
//
//  Created by Max Konovalov on 03/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Arrow

@Suite
struct CustomRawRepresentableTests {
    
    var customRawRepresentableContainer = CustomRawRepresentableContainer()
    
    init() {
        if let json: JSON = mockJSON() {
            customRawRepresentableContainer <-- json
        }
    }
    
    @Test
    func testParsingCustomModel() {
        #expect(customRawRepresentableContainer.identifier == 15678)
        #expect(customRawRepresentableContainer.rawValue == "15678")
    }
}
