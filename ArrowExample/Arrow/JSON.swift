//
//  JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 14/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public class JSON:AnyObject, CustomDebugStringConvertible { //Struct??
    
    public var data:AnyObject?
    
    public init?(_ dic:AnyObject?) {
        data = dic
    }
    
    public var debugDescription: String {
        return data!.debugDescription
    }
    
}

public extension JSON {
    
    subscript(key: String) -> AnyObject? {
        get {
            let keys =  key.characters.split{$0 == "."}.map(String.init)
            var intermediateValue:AnyObject? = data
            for k in keys {
                if let value = intermediateValue?[k] {
                    intermediateValue = value
                } else {
                    return nil
                }
            }
            return intermediateValue
        }
        set(obj) {
            if var d = data as? [String:AnyObject] {
                d[key] = obj
            }
        }
    }
    
    subscript(index: Int) -> JSON? {
        get {
            if let array = data as? [AnyObject] where array.count > index {
                return JSON(array[index])
            } else {
                return nil
            }
        }
    }
    
}