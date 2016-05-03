//
//  PhoneNumber+JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 13/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Arrow

//===

extension PhoneNumber: ArrowParsable
{
    mutating
    func deserialize(json: JSON)
    {
        label <-- json["label"]
        number <-- json["number"]
    }
}