//
//  FooTests.swift
//  ArrowTests
//
//  Created by Sacha DSO on 26/06/2018.
//  Copyright © 2018 Sacha Durand Saint Omer. All rights reserved.
//

import XCTest
import Arrow

class FooTests: XCTestCase {
    
    func testFooCodableParsing() {
        let jsonString = "{ \"pseudo\" : \"bar\" }"
        if let jsondata = jsonString.data(using: .utf8) {
            let foo = try? JSONDecoder().decode(Foo.self, from: jsondata)
            XCTAssertEqual(foo?.name, "bar")
        } else {
            XCTFail("NO JSON DATA")
        }
    }

    func testFooArrowParsing() {
        let json = JSON("{ \"pseudo\" : \"bar\" }")!
        let foo = FooArrow(json)
        XCTAssertEqual(foo.name, "bar")
    }
}

// Avantages
// Native
// a be used with let
// default to the property name.
// Coding keys are oimplementable in an extension.

// Drawbacks
// Codable needed on the type itself

// Arrow ADVANTAGES
// Model can be left untouched. pure struct, not codable.

// Arrow Drawbacks
// - need to have var.
// Need to have empty init
// Need to create an instance and then parse. no init(form: json).
// can `codable` give a default impl?

extension Foo {
    enum CodingKeys: String, CodingKey {
        case name = "pseudo"
    }
}

extension FooArrow: ArrowImmutableInitializable {

    init(_ json: JSON) {
        name = json["pseudo"] ?? "default"
    }
}



// Improvements
// Bettter ArrowInitializable syntax.
// Enables using let instead of var --> Immutibily FTW
// removes the arrow intialisator, so less things to learn, pure swift syntax
