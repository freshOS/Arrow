//
//  Arrow.swift
//  Swift Structs Test
//
//  Created by Sacha Durand Saint Omer on 6/7/15.
//  Copyright (c) 2015 Sacha Durand Saint Omer. All rights reserved.
//

private
let dateFormatter = NSDateFormatter()

private
var useReferenceDate = false

//=== MARK: - Protocols

public
protocol ArrowParsable
{
    init()
    mutating func deserialize(json:JSON)
}

public
protocol ArrowInitializable
{
    init(json:JSON)
}

//=== MARK: - Singlton

public
final
class Arrow
{
    public
    class
    func setDateFormat(format:String)
    {
        dateFormatter.dateFormat = format
    }
    
    public
    class
    func setUseTimeIntervalSinceReferenceDate(ref:Bool)
    {
        useReferenceDate = ref
    }
}


//=== MARK: - Custom operator

infix
operator <-- {}

//=== MARK: - Custom operator - Parse system Swift types

public
func <-- <T>(inout left: T, right: JSON?)
{
    var temp:T? = nil
    
    parseType(&temp, right:right)
    
    if
        let t = temp
    {
        left = t
    }
}

//=== MARK: - Custom operator - Support optional Data

public
func <-- <T>(inout left: T?, right: JSON?)
{
    parseType(&left, right: right)
}

func parseType<T>(inout left:T?,right:JSON?)
{
    if
        let v: T = right?.data as? T
    {
        left = v
    }
    else
    if
        let s = right?.data as? String
    {
        switch T.self
        {
            case is Int.Type: if let v = Int(s) { left = v as? T }
            case is UInt.Type: if let v = UInt(s) { left = v as? T }
            case is Double.Type: if let v = Double(s) { left = v as? T }
            case is Float.Type: if let v = Float(s) { left = v as? T }
            case is CGFloat.Type: if let v = CGFloat.NativeType(s) { left = CGFloat(v) as? T }
            case is Bool.Type: if let v = Int(s) { left = Bool(v) as? T}
            
            default:()
        }
    }
}

//=== MARK: - Custom operator - Support Enum

public
func <-- <T: RawRepresentable>(inout left: T, right: JSON?)
{
    var temp: T.RawValue? = nil
    
    parseType(&temp, right:right)
    
    if
        let t = temp,
        e = T.init(rawValue: t)
    {
        left = e
    }
}

public
func <-- <T: RawRepresentable>(inout left: T?, right: JSON?)
{
    var temp: T.RawValue? = nil
    
    parseType(&temp, right:right)
    
    if
        let t = temp,
        e = T.init(rawValue: t)
    {
        left = e
    }
}

//=== MARK: - Custom operator - Parse Custom Types

public
func <-- <T: ArrowParsable>(inout left:T, right: JSON?)
{
    if
        let data = right?.data
    {
        left = T.init()
        left.deserialize(JSON(data))
    }
}

public
func <-- <T: ArrowParsable>(inout left:T?, right: JSON?)
{
    if
        let data = right?.data
    {
        left = T.init()
        left?.deserialize(JSON(data))
    }
}

//=== MARK: - Custom operator - Array of custom Types

public
func <-- <T: ArrowParsable>(inout left:[T], right: JSON?)
{
    if
        let a = right?.data as? [AnyObject]
    {
        left = a.map {
            
            var result = T.init()
            result.deserialize(JSON($0))
            
            //===
            
            return result  //TODO return t even if T not parsable?? // what???
        }
    }
}

public
func <-- <T: ArrowParsable>(inout left:[T]?, right: JSON?)
{
    if
        let a = right?.data as? [AnyObject]
    {
        left = a.map {
            
            var result = T.init()
            result.deserialize(JSON($0))
            
            //===
            
            return result  //TODO return t even if T not parsable?? // what???
        }
    }
}

//=== MARK: - Custom operator - NSDate Parsing

public
func <-- (inout left: NSDate, right: JSON?)
{
    var temp: NSDate? = nil
    
    parseDate(&temp, right:right)
    
    if
        let t = temp
    {
        left = t
    }
}

public
func <-- (inout left: NSDate?, right: JSON?)
{
    parseDate(&left, right:right)
}

func parseDate(inout left:NSDate?,right:JSON?)
{
    // Use custom date format over high level setting when provided
    if
        let customFormat = right?.jsonDateFormat
    {
        if
            let s = right?.data as? String
        {
            let df = NSDateFormatter()
            df.dateFormat = customFormat
            left = df.dateFromString(s)
        }
    }
    else
    {
        if
            let s = right?.data as? String
        {
            if
                let date = dateFormatter.dateFromString(s)
            {
                left = date
            }
            else
            if let t = NSTimeInterval(s)
            {
                left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
            }
        }
        else
        if let t = right?.data as? NSTimeInterval
        {
            left = useReferenceDate ? NSDate(timeIntervalSinceReferenceDate: t) : NSDate(timeIntervalSince1970: t)
        }
    }
}

//=== MARK: - Custom operator - NSURL Parsing

public
func <-- (inout left: NSURL, right: JSON?)
{
    var temp: NSURL? = nil
    
    parseURL(&temp, right:right)
    
    if
        let t = temp
    {
        left = t
    }
}

public
func <-- (inout left: NSURL?, right: JSON?)
{
    parseURL(&left, right: right)
}

func parseURL(inout left:NSURL?, right:JSON?)
{
    var str = ""
    str <-- right
    
    if
        let url = NSURL(string:str)
    {
        left = url
    }
}

//=== MARK: - Custom operator - Support Array of plain Types

//TODO : No tests Validaing "Support Array of plain Types"

func parseArray<T>(inout left: [T]?, right: JSON?)
{
    if
        let a = right?.data as? [AnyObject]
    {
        let tmp: [T] = a.flatMap { var t: T?; parseType(&t, right: JSON($0)); return t }
        
        if tmp.count == a.count
        {
            left = tmp
        }
    }
}

public
func <-- <T>(inout left: [T], right: JSON?)
{
    var temp:[T]? = nil
    
    parseArray(&temp, right:right)
    
    if let t = temp
    {
        left = t
    }
}

public
func <-- <T>(inout left: [T]?, right: JSON?)
{
    parseArray(&left, right: right)
}

//=== MARK: - Custom operator - Initializable

infix
operator <--/ {}

public
func <--/ <T: ArrowInitializable>(inout left:T, right: JSON?)
{
    if
        let data = right?.data
    {
        left = T.init(json: JSON(data))
    }
}

public
func <--/ <T: ArrowInitializable>(inout left:T?, right: JSON?)
{
    if
        let data = right?.data
    {
        left = T.init(json: JSON(data))
    }
}

public
func <--/ <T: ArrowInitializable>(inout left:[T], right: JSON?)
{
    if
        let a = right?.data as? [AnyObject]
    {
        left = a.map {
            
            return
                T.init(json: JSON($0)) //TODO return t even if T not parsable?? // what???
        }
    }
}

public
func <--/ <T: ArrowInitializable>(inout left:[T]?, right: JSON?)
{
    if
        let a = right?.data as? [AnyObject]
    {
        left = a.map {
            
            return
                T.init(json: JSON($0)) //TODO return t even if T not parsable?? // what???
        }
    }
}
