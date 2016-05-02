//
//  JSON.swift
//  ArrowExample
//
//  Created by Sacha Durand Saint Omer on 14/04/16.
//  Copyright © 2016 Sacha Durand Saint Omer. All rights reserved.
//

public
final
class JSON: AnyObject, CustomDebugStringConvertible
{
    //=== Public properties
    
    public
    var jsonDateFormat: String?
    
    //=== Public read-ONLY properties
    
    private(set)
    public
    var data: AnyObject
    
    //=== Initialization
    
    public
    init(_ deserializedData: AnyObject)
    {
        data = deserializedData
    }
    
    //=== Access data
    
    public
    subscript(key: String) -> JSON?
    {
        get
        {
            var result: JSON? = nil
            
            //===
            
            let keys = key.characters.split{$0 == "."}
            
            if keys.count > 1 // KeyPath parsing
            {
                let keysArray:[String] =  keys.map(String.init)
                
                result = JSON(data)
                
                for k in keysArray
                {
                    if let ik = Int(k) // Array index
                    {
                        if
                            let value = result?[ik]
                        {
                            result = value
                        }
                        else
                        {
                            result = nil
                            break
                        }
                    }
                    else // Key
                    {
                        if
                            let value = result?[k]
                        {
                            result = value
                        }
                        else
                        {
                            result = nil
                            break
                        }
                    }
                }
            }
            else // Regular parsing
            {
                if
                    let x = data[key] // relay on system built-in subscripting???
                {
                    result = JSON(x!) // subJSON
                }
            }
            
            //===
            
            return result
        }
        
        set(newValue)
        {
            if
                var d = data as? [String:AnyObject]
            {
                d[key] = newValue
            }
        }
    }
    
    public
    subscript(index: Int) -> JSON?
    {
        get
        {
            if
                let array = data as? [AnyObject] where array.count > index
            {
                return JSON(array[index])
            }
            else
            {
                return nil
            }
        }
        
        // TODO: add "set" method implementation?
    }
}

//=== MARK: - Helpers

extension JSON
{
    public
    var collection: [JSON]?
    {
        if
            let a = data as? [AnyObject]
        {
            return a.map{ JSON($0) }
        }
        else
        {
            return nil
        }
    }
    
    public
    var debugDescription: String
    {
        return data.debugDescription
    }
    
    public
    func dateFormat(format: String) -> Self
    {
        jsonDateFormat = format
        
        //===
        
        return self
    }
}
