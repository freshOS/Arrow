# Arrow <--
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Arrow is a Dead simple Swift JSON Parsing library

```swift
identifier <-- json["id"]
name <-- json["name"]
stats <== json["stats"]
```

## Core Principles
- [x] Leaves your models clean
- [x] Implicitely casts JSON values to the right types in your model
- [x] Does not crash if JSON key is not there, nor returns nil, it simply doesn't do anything
- [x] NSDate Parsing
- [x] Simple
- [x] Extensible
- [x] Easy to use
- [x] Lightweght (80 lines of code)

## Installation
#### Using Carthage
```
github "s4cha/Arrow"
```
#### Manually
Simply Copy and Paste Arrow.swift in your Xcode Project :)

#### As A Framework
Grab this repository and build the Framework target on the example project. Then Link against this framework.

## Why Another Swift JSON Parsing Library?

Well the answer is prettry simple. All the others are simply not good enough.
Or at at least none of them meet our requirements for what we beleive makes a truely good JSON Library :

- Most of them force us to subclass our models. The fact that we get data as a JSON representation is a DETAIL and should not leak in our app architecture (right uncle bob?! :p) So there is no reason that using a particular library to parse Json would force us to come back to our pretty models and subclass them with some obscure class. And what if your models aldready subclass something anyway, say NSManagedObject? well you're pretty much screwed :p

- Some use overly complex obscure functional chaining operator overloading voodoo magic. We want something that's readable by a regular human being.

- Most need us to explicitely cast the Json value to the correposnding type on our model. We think this is crazy! The type is already there in our model class, can't we just implicitly cast it then?


## Ok I'm sold, Now show me the code

#### Swift Model
```swift
struct Profile {
    var identifier = 0
    var name = ""
    var stats = Stats()
}
```
#### JSON File
```json
{
    "id": 15678,
    "name": "John Doe",
    "stats": {
        "numberOfFriends": 163,
        "numberOfFans": 10987
    }
}
```
#### Usual Swift JSON Parsing (Chaos)
```swift
var profile = Profile()
if let id = json["id"] as? Int {
    profile.identifier = id
}  
if let name = json["name"] as? String {
    profile.name = name
}
if let statsJson = json["stats"] as? AnyObject {
    if let numberOfFans = statsJson["numberOfFans"] as? Int {
        profile.stats.numberOfFans = numberOfFans
    }
    if let numberOfFriends = statsJson["numberOfFriends"] as? Int {
        profile.stats.numberOfFriends = numberOfFriends
    }
}
```
#### With Arrow --> Sanity preserved
```swift
extension Profile:ArrowParsable {
    init(json: JSON) {
        identifier <-- json["id"]
        name <-- json["name"]
        stats <== json["stats"]
    }
}
```
## Integration
- Step 1 - Copy paste Arrow.swift in your Xcode Project
- Step 2 - Create you model parsing extension like so : "Profile+Arrow.swift"
```swift
// Profile+Arrow.swift
extension Profile:ArrowParsable {
    init(json: JSON) {
        identifier <-- json["id"]
        name <-- json["name"]
        stats <== json["stats"]
    }
}
```
- Step 3 - Use it:
```swift
let profile = Profile(json: json)
```
- Step 4 - Ther is no step 4

 
## How Does that work

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
    init(json: JSON) {
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

- Hey I don't want to parse NSDates in evry files, do you have something for me?


Sure, just set your date format once and you're done.

```swift
    // Configure NSDate Parsing
    Arrow.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
```
## Acknoledgments
This wouldn't exist without YannickDot (https://github.com/YannickDot) and Damien-nd (https://github.com/damien-nd)
<3
