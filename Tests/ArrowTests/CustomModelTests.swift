//
//  CustomModelTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Foundation
import Arrow

@Suite
struct CustomModelTests {
    
    var customModelContainer = CustomModelContainer()

    init() {
        if let json: JSON = mockJSON() {
            customModelContainer <-- json
        }
    }
    
    @Test
    func testParsingCustomModel() {
        #expect(customModelContainer.stats.numberOfFriends == 163)
        #expect(customModelContainer.stats.numberOfFans == 10987)
    }
    
    @Test
    func testParsingOptionalCustomModel() {
        #expect(customModelContainer.optionalStats?.numberOfFriends == 163)
        #expect(customModelContainer.optionalStats?.numberOfFans == 10987)
    }
    
    @Test
    func testParsingIssue() {
        let myJson = "{ \"homer\": \"simpson\"}"
        guard let jsonData = myJson.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers),
            let json = JSON(jsonObject) else {
            return
        }
        var aSimpson = Doh()
        aSimpson.deserialize(json)
        #expect(aSimpson.homer == "simpson")
    }
    
    @Test
    func testParsingIssueWorksWithString() {
        let myJson = "{ \"homer\": \"simpson\"}"
        guard let json = JSON(myJson) else {
            return
        }
        var aSimpson = Doh()
        aSimpson.deserialize(json)
        #expect(aSimpson.homer == "simpson")
    }

}

struct Doh: Codable {
    var homer = ""
}

extension Doh: ArrowParsable {
    public mutating func deserialize(_ json: JSON) {
        homer <-- json["homer"]
    }
}
