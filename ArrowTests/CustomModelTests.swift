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
    
    func testParsingIssue() {
        let myJson = "{ \"homer\": \"simpson\"}"
        guard let jsonData = myJson.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers),
            let json = JSON(jsonObject) else {
            return
        }
        var aSimpson = Doh()
        aSimpson.deserialize(json)
        XCTAssertEqual(aSimpson.homer, "simpson")
    }
    
    func testParsingIssueWorksWithString() {
        let myJson = "{ \"homer\": \"simpson\"}"
        guard let json = JSON(myJson) else {
            return
        }
        var aSimpson = Doh()
        aSimpson.deserialize(json)
        XCTAssertEqual(aSimpson.homer, "simpson")
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
