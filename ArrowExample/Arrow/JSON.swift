//
//  JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 14/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation

public class JSON:AnyObject, CustomDebugStringConvertible { //Struct??
    
    public func dateFormat(format:String) -> Self {
        jsonDateFormat = format
        return self
    }
    
    public var jsonDateFormat:String?
    
    public var data:AnyObject?
    
    public init?(_ dic:AnyObject?) {
        if dic == nil {
            return nil
        } else {
            data = dic
        }
    }
    
    public var debugDescription: String {
        return data!.debugDescription
    }
    
    public subscript(key: String) -> JSON? {
        get {
            let keys =  key.characters.split{$0 == "."}
            if keys.count > 1 { // KeyPath parsing
                let keysArray:[String] =  keys.map(String.init)
                if var intermediateValue = JSON(data) {
                    for k in keysArray {
                        if let value = intermediateValue[k] {
                            intermediateValue = value
                        } else {
                            return nil
                        }
                    }
                    return intermediateValue
                }
            } else { // Regular parsing
                if let d = data, x = d[key], subJSON = JSON(x) {
                    return subJSON
                }
            }
            return nil
        }
        set(obj) {
            if var d = data as? [String:AnyObject] {
                d[key] = obj
            }
        }
    }
    
    public subscript(index: Int) -> JSON? {
        get {
            if let array = data as? [AnyObject] where array.count > index {
                return JSON(array[index])
            } else {
                return nil
            }
        }
    }

}