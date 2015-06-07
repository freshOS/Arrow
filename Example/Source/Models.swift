//
//  Models.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

//: Playground - noun: a place where people can play


// Goals

//Single "sandalone" Models files with no exterior logic or no networking or no json parsing logic
// Models only depend on intrefaces, use composition over inheritance.

// Refactor parsing bits into parts say resource part/ author part etc.

//  Untouches models ,not leaking , can cahnge our architecture whenevr (like girl frineds)
// Struct models
// Simple
// Easy to use


struct Stats {
    var numberOfFriends = 0
    var numberOfFans = 0
}

struct Profile {
    var identifier = 0
    var name = ""
    var stats = Stats()
}
