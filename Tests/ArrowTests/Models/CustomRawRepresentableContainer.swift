//
//  CustomRawRepresentableContainer.swift
//  Arrow
//
//  Created by Max Konovalov on 03/11/2016.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

struct CustomRawRepresentableContainer {
    var identifier: Int = 0
}

extension CustomRawRepresentableContainer: RawRepresentable {
    
    init?(rawValue: String) {
        guard let id = Int(rawValue) else {
            return nil
        }
        self.identifier = id
    }
    
    var rawValue: String {
        return "\(identifier)"
    }
    
}
