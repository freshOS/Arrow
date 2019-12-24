//
//  File.swift
//  
//
//  Created by Sacha DSO on 24/12/2019.
//

import Arrow
import Foundation

func mockJSON() -> JSON? {

    let jsonString = """
    {
        "id": "15678",
        "weekdayInt" : 3,
        "difficulty": "high",
        "link": "https://apple.com/steve",
        "emoji_link": "http://🆒🔗.ws",
        "accent_link": "http://gégé.com",
        "created_at" : "2013-06-07T16:38:40+02:00",
        "created_at_timestamp" : "392308720",
        "name": "Francky",
        "stats": {
            "numberOfFriends": 163,
            "numberOfFans": 10987
        },
        "phoneNumbers": [{
                         "label": "house",
                         "number": "9809876545"
                         }, {
                         "label": "cell",
                         "number": "0908070656"
                         }, {
                         "label": "work",
                         "number": "0916570656"
        }],
        "strings": ["one", "two", "three"],
        "ints": [1, 2, 3],
        "bools": [true, false, true],
        "bool": true,
        "float" : 0.12,
        "double" : 0.123456789,
        "floatString" : "0.12",
        "doubleString" : "0.123456789",
        
        "nested":{
            "nested" : {
                "nested" : {
                    "nestedValue" : "42"
                }
            }
        },
        "nestedArray" : ["one", "two", "Cool", "four"],
        "weekdays": [1, 3, 5],
        "dict": { "one": "1", "two": "2" }
    }

    """
    if let jsonData = jsonString.data(using: String.Encoding.utf8),
        let json = ((try? JSONSerialization.jsonObject(with: jsonData,
                                                       options: .mutableContainers) as? NSDictionary) as NSDictionary??),
     let dic = json as? [String: Any] {
        return JSON(dic)
    }
    return nil
}
    
   
