//
//  URLTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class URLTests: XCTestCase {
    
    var urlContainer = URLContainer()
    
    override func setUp() {
        super.setUp()
        if let json: JSON = jsonForName("Profile") {
            urlContainer = URLContainer()
            urlContainer.deserialize(json)
        }
    }
    
    func testParsingURL() {
        XCTAssertEqual(urlContainer.link.absoluteString
            .stringByRemovingPercentEncoding, "https://apple.com/steve")
    }
    
    func testParsingEmojiURL() {
        XCTAssertEqual(urlContainer.emojiLink.absoluteString
            .stringByRemovingPercentEncoding, "http://🆒🔗.ws")
    }
    
    func testParsingAccentURL() {
        XCTAssertEqual(urlContainer.accentLink.absoluteString
            .stringByRemovingPercentEncoding, "http://gégé.com")
    }
    
    func testParsingOptionalURL() {
        XCTAssertEqual(urlContainer.optionalLink?.absoluteString
            .stringByRemovingPercentEncoding, "https://apple.com/steve")
    }
}
