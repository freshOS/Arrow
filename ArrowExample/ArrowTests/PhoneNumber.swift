//
//  PhoneNumber.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 30/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct PhoneNumber {
    var label:String = ""
    var number:String = ""
}


import Arrow

extension PhoneNumber: ArrowParsable {
    
    init(json: JSON) {
        label <-- json["label"]
        number <-- json["number"]
    }
}