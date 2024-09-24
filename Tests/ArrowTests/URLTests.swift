//
//  URLTests.swift
//  Arrow
//
//  Created by Sacha Durand Saint Omer on 10/07/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Testing
import Arrow

@Suite
struct URLTests {
    
    var urlContainer = URLContainer()
    
    init() {
        if let json: JSON = mockJSON() {
            urlContainer <-- json
        }
    }
    
    @Test
    func parsingURL() {
        #expect(urlContainer.link.absoluteString.removingPercentEncoding == "https://apple.com/steve")
    }
    
    @Test
    func parsingEmojiURL() {
        #expect(urlContainer.emojiLink.absoluteString.removingPercentEncoding == "http://🆒🔗.ws")
    }
    
    @Test
    func parsingAccentURL() {
        #expect(urlContainer.accentLink.absoluteString.removingPercentEncoding == "http://gégé.com")
    }
    
    @Test
    func parsingOptionalURL() {
        #expect(urlContainer.optionalLink?.absoluteString.removingPercentEncoding == "https://apple.com/steve")
    }
}
