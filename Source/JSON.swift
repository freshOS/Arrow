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
open class JSON {
    
    /// This is the raw data of the JSON
    open var data: Any?
    
    /// This date formating strategy that will be used for that JSON section.
    /// This should not be set, use `dateFormat` instead.
    internal var jsonDateFormat: String?
    
    internal var jsonDateFormatter: DateFormatter?
    
    /// This build a JSON object with raw data.
    public init?(_ data: Any?) {
        guard let data = data else {
            return nil
        }
        self.data = data
    }
    
    /**
     - Returns: The array of JSON values. In case of the JSON being a dictionary,
     this will return nil.
     */
    open var collection: [JSON]? {
        guard let a = data as? [Any] else {
            return nil
        }
        return a.map { JSON($0) }.flatMap {$0}
    }
    
    /**
     This defines the date format to be used for NSDate parsing.
 
         createdAt <-- json["created_at"]?.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
     
     - Returns: Itself for chaining purposes.
     */
    open func dateFormat(_ format: String) -> Self {
        jsonDateFormat = format
        return self
    }
    
    open func dateFormatter(_ formatter: DateFormatter) -> Self {
        jsonDateFormatter = formatter
        return self
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
        guard let d = data as? [String: Any], let x = d[key], let subJSON = JSON(x) else {
            return nil
        }
        return subJSON
    }
    
    open subscript(key: String) -> JSON? {
        get { return isKeyPath(key) ? parseKeyPath(key) : regularParsing(key) }
        set(obj) {
            if var d = data as? [String:Any] {
                d[key] = obj
            }
        }
    }
    
    open subscript(index: Int) -> JSON? {
        get {
            guard let array = data as? [Any], array.count > index else {
                return nil
            }
            return JSON(array[index])
        }
    }
}

extension JSON: CustomDebugStringConvertible {
    
    /// This is just for supporting default console logs.
    open var debugDescription: String {
        return data.debugDescription
    }
    
}
