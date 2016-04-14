# Arrow 🏹 - *Elegant JSON Parsing in Swift*

[![Language: Swift 2](https://img.shields.io/badge/language-swift2-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://www.bitrise.io/app/ffd8fe5df34624ff.svg?token=IahWn-RB5hTWzvBbcIktsQ)](https://www.bitrise.io/app/ffd8fe5df34624ff)
[![codebeat badge](https://codebeat.co/badges/2acb8664-02f7-463d-9de2-2be9e87ba17c)](https://codebeat.co/projects/github-com-s4cha-arrow)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/s4cha/Arrow/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.7-blue.svg)]()


[Reason](#reason) - [Example](#example) - [Installation](#installation)


```swift
identifier <-- json["id"]
name <-- json["name"]
stats <== json["stats"]
```

## Reason
### Why
Because parsing JSON in Swift is full of **unecessary if lets, obvious casts and nil-checks**  
*There must be a better way*

## How
By using a simple arrow operator that takes care of the boilerplate code for us.  
Json mapping code becomes **concise** and **maintainable** ❤️


## What
- [x] Simple & Lightweight (~100lines)
- [x] Pure Swift
- [x] Leaves your models clean
- [x] Implicitly casts JSON values to the right types in your model
- [x] Converts string values to numeric types in your model
- [x] Does not crash if JSON key is not there, nor returns nil, it simply doesn't do anything
- [x] NSDate Parsing
- [x] No overly complex obscure functional chaining operator overloading voodoo magic ?==:>>><> 😅


## Example

### Swift Model
```swift
struct Profile {
    var identifier = 0
    var name = ""
    var link:NSURL?
    var weekday:WeekDay = .Monday
    var stats = Stats()
    var phoneNumbers = [PhoneNumber]()
}
```
### JSON File
```json
{
    "id": 15678,
    "name": "John Doe",
    "link": "https://apple.com/steve",
    "weekdayInt" : 3,
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
    }]
}
```

### Before (Chaos)
```swift
var profile = Profile()

// Int
if let id = json["id"] as? Int {
    profile.identifier = id
}  
// String
if let name = json["name"] as? String {
    profile.name = name
}
// NSURL
if let link = json["link"] as? String, url = NSURL(string:link)  {
    profile.link = link
}
// Enum
if let weekdayInt = json["weekdayInt"] as? Int, weekday = WeekDay(rawValue:weekdayInt) {
    profile.weekday = weekday
}
// Custom nested object
if let statsJson = json["stats"] as? AnyObject {
    if let numberOfFans = statsJson["numberOfFans"] as? Int {
        profile.stats.numberOfFans = numberOfFans
    }
    if let numberOfFriends = statsJson["numberOfFriends"] as? Int {
        profile.stats.numberOfFriends = numberOfFriends
    }
}
// Array of custom nested object
if let pns = json["phoneNumbers"] as? [AnyObject] {
    for pn in pns {
        phoneNumbers.append(PhoneNumber(json: pn))
    }
}
```

### After  🎉🎉🎉
```swift
extension Profile:ArrowParsable {
    mutating func deserialize(json: JSON) {
        identifier <-- json["id"]
        link <-- json["link"]
        name <-- json["name"]
        weekday <-- json["weekdayInt"]
        stats <== json["stats"]
        phoneNumbers <== json["phoneNumbers"]
    }
}
```

### Usage
```swift
let profile = Profile(json: json)
```

## Installation
#### Using Carthage
```
github "s4cha/Arrow"
```
#### Manually
Simply Copy and Paste Arrow.swift in your Xcode Project :)
https://github.com/s4cha/Arrow/blob/master/Arrow.swift

#### As A Framework
Grab this repository and build the Framework target on the example project. Then Link against this framework.


## How Does That Work

- <-- Arrow Operator is for all Swift Types : Int.. Double .. String .. NSDate etc
- <== Thick Arrow Operator is for your own custom models

Notice earlier we typed :

```swift
stats <== json["stats"]
```
That's because we created and extension "Stats+Arrow.swift" enabling us to use the thick Arrow Operator

```swift
//  Stats+Arrow.swift

import Foundation

extension Stats:ArrowParsable {
    mutating func deserialize(json: JSON) {
        numberOfFriends <-- json["numberOfFriends"]
        numberOfFans <-- json["numberOfFans"]
    }
}
```

## Flexible you said

- DO I have to use the <== for my sub models
- Nope, you could write it like so if you wanted :

```swift
stats.numberOfFriends <-- json.valueForKeyPath("stats.numberOfFriends")
stats.numberOfFans <-- json.valueForKeyPath("stats.numberOfFans")
```

- Hey I don't want to parse NSDates in every files, do you have something for me?


Sure, just set your date format once and you're done.

```swift
// Configure NSDate Parsing
Arrow.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
Arrow.setUseTimeIntervalSinceReferenceDate(true)

// Dates can be parsed form custom date format or timestamp
let json = ["date": "2013-06-07T16:38:40+02:00", "timestamp": 392308720]
date1 <-- json["date"]
date2 <-- json["timestamp"]
```
## Acknoledgments
This wouldn't exist without [YannickDot](https://github.com/YannickDot), [Damien-nd](https://github.com/damien-nd) and [maxkonovalov](https://github.com/maxkonovalov)


## Other repos ❤️
Arrow is part of a series of lightweight libraries aiming to make developing iOS Apps a *breeze* :
- Layout : [Stevia](https://github.com/s4cha/Stevia)
- Async code : [then](https://github.com/s4cha/then)
- JSON WebServices : [ws](https://github.com/s4cha/ws)
