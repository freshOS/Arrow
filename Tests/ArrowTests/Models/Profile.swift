//
//  Profile.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 29/03/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct Profile {
    var identifier = 0
    var double: Double = 0.0
    var float: Float = 0.0
    var cgfloat: CGFloat = 0.0
}

extension Profile: RawRepresentable {
    
    init?(rawValue: String?) {
        
    }
    
    var rawValue: String? {
        return ""
    }
    
}
