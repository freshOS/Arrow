//
//  JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 14/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

import Foundation
/**
 This abstraction helps working with the JSON Format.
 
 It provives a way to access JSON values via subscripting, whether
 it's an array or a dictionary.
 */
public class JSON: AnyObject, CustomDebugStringConvertible {
    
    /// This is the raw data of the JSON
    public var data: AnyObject?
    
    /// This date formating strategy that will be used for that JSON section.
    /// This should not be set, use `dateFormat` instead.
    public var jsonDateFormat: String?
    
    /// This build a JSON object with raw data.
    public init?(_ dic: AnyObject?) {
        if dic == nil {
            return nil
        } else {
            data = dic
        }
    }
    
    /**
     - Returns: The array of JSON values. In case of the JSON being a dictionary,
     this will return nil.
     */
    public var collection: [JSON]? {
        if let a = data as? [AnyObject] {
            return a.map { JSON($0) }.flatMap {$0}
        } else {
            return nil
        }
    }
    
    /**
     This defines the date format to be used for NSDate parsing.
 
         createdAt <-- json["created_at"]?.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
     
     - Returns: Itself for chaining purposes.
     */
    public func dateFormat(_ format: String) -> Self {
        jsonDateFormat = format
        return self
    }
    
    /// This is just for supporting default console logs.
    public var debugDescription: String {
        if let data = data {
            return data.debugDescription
        }
        return ""
    }
    
    public subscript(key: String) -> JSON? {
        get { return isKeyPath(key) ? parseKeyPath(key) : regularParsing(key) }
        set(obj) {
            if var d = data as? [String:AnyObject] {
                d[key] = obj
            }
        }
    }
    
    func isKeyPath(_ key: String) -> Bool {
        return key.characters.split {$0 == "."}.count > 1
    }
    
    func parseKeyPath(_ keyPath: String) -> JSON? {
        if var intermediateValue = JSON(data) {
            for k in keysForKeyPath(keyPath) {
                if !tryParseJSONKeyPathKey(k, intermediateValue: &intermediateValue) {
                    return nil
                }
            }
            return intermediateValue
        }
        return nil
    }
    
    func keysForKeyPath(_ keyPath: String) -> [String] {
        return keyPath.characters.split {$0 == "."}.map(String.init)
    }
    
    func tryParseJSONKeyPathKey(_ key: String, intermediateValue: inout JSON) -> Bool {
        if let ik = Int(key), let value = intermediateValue[ik] { // Array index
            intermediateValue = value
        } else if let value = intermediateValue[key] { //key
            intermediateValue = value
        } else {
            return false
        }
        return true
    }
    
    func regularParsing(_ key: String) -> JSON? {
        if let d = data, let x = d[key], let subJSON = JSON(x as AnyObject?) {
            return subJSON
        }
        return nil
    }
    
    public subscript(index: Int) -> JSON? {
        get {
            if let array = data as? [AnyObject], array.count > index {
                return JSON(array[index])
            } else {
                return nil
            }
        }
    }
}
