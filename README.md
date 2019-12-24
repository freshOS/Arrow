![Arrow](https://raw.githubusercontent.com/freshOS/Arrow/master/banner.png)

# Arrow

[![Language: Swift 5](https://img.shields.io/badge/language-swift5-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
[![Build Status](https://app.bitrise.io/app/ffd8fe5df34624ff/status.svg?token=IahWn-RB5hTWzvBbcIktsQ&branch=master)](https://app.bitrise.io/app/ffd8fe5df34624ff)
[![codebeat badge](https://codebeat.co/badges/f037ac0c-b3d9-4132-9fca-64150a908113)](https://codebeat.co/projects/github-com-freshos-arrow)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/freshOS/Arrow/blob/master/LICENSE)
![Release version](https://img.shields.io/github/release/freshos/Arrow.svg)

[Reason](#reason) - [Example](#example) - [Installation](#installation)


```swift
identifier <-- json["id"]
name <-- json["name"]
stats <-- json["stats"]
```

Because parsing JSON in Swift is full of **unecessary if lets, obvious casts and nil-checks**  
*There must be a better way*

## Try it

Arrow is part of [freshOS](http://freshos.org) iOS toolset. Try it in an example App ! <a class="github-button" href="https://github.com/freshOS/StarterProject/archive/master.zip" data-icon="octicon-cloud-download" data-style="mega" aria-label="Download freshOS/StarterProject on GitHub">Download Starter Project</a>

## How
By using a simple arrow operator that takes care of the boilerplate code for us.  
Json mapping code becomes **concise** and **maintainable** ❤️


## Why use Arrow
- [x] Infers types
- [x] Leaves your models clean
- [x] Handles custom & nested models
- [x] Dot and array syntax
- [x] Pure Swift, Simple & Lightweight

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
        stats <- json["stats"]
        phoneNumbers <-- json["phoneNumbers"]
    }
}
```

### Usage
```swift
let profile = Profile()
profile.deserialize(json)
```

## Installation
The Swift Package Manager (SPM) is now the official way to install `Arrow`. The other package managers are now deprecated as of `5.1.2` and won't be supported in future versions.

#### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourPackage",
    ...
    dependencies: [
        .package(url: "https://github.com/freshOS/Arrow", .exact("5.1.3")) // <-  1. Declare dependency
        //...
    ],
    targets: [
        .target(name: "YourPackage", dependencies:["Arrow"]), // <-  2. Link it to your target
    ]
)
```

#### Carthage - Deprecated
```
github "freshOS/Arrow"
```
#### CocoaPods - Deprecated
```
target 'MyApp'
pod 'Arrow'
use_frameworks!
```

## How Does That Work

Notice earlier we typed :

```swift
stats <-- json["stats"]
```
That's because we created and extension "Stats+Arrow.swift" enabling us to use the Arrow Operator

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

- DO I have to use the <-- for my sub models
- Nope, you could write it like so if you wanted :

```swift
stats.numberOfFriends <-- json["stats.numberOfFriends"]
stats.numberOfFans <-- json["stats.numberOfFans"]
```

## Date Parsing

### Globally

```swift
// Configure Global Date Parsing with one of those
Arrow.setDateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
Arrow.setUseTimeIntervalSinceReferenceDate(true)
Arrow.setDateFormatter(aDateFormatter)

// Then later dates can be parsed form custom date format or timestamps automatically 🎉
let json:JSON = JSON(["date": "2013-06-07T16:38:40+02:00", "timestamp": 392308720])
date1 <-- json["date"]
date2 <-- json["timestamp"]
```

### On a per-key basis
```swift
createdAt <-- json["created_at"]?.dateFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
createdAt <-- json["created_at"]?.dateFormatter(aCustomDateFormatter)
```
Just provide it on a case per case basis ! 🎉

## Accessing JSON values

### Nested values

```swift
value <-- json["nested.nested.nested.nestedValue"]
```

### Object at index
```swift
value <-- json[12]
```

### Combine both
```swift
value <-- json[1]?["someKey"]?[2]?["something.other"]
```

### Looping on Array
```swift
if let collection = json.collection {
    for jsonEntry in collection {
        //Do something
    }
}
```

## Swift Version

- Swift 2 -> version [**2.0.3**](https://github.com/freshOS/Arrow/releases/tag/2.0.3)
- Swift 3 -> version [**3.0.5**](https://github.com/freshOS/Arrow/releases/tag/3.0.5)
- Swift 4 -> version [**4.0.0**](https://github.com/freshOS/Arrow/releases/tag/4.0.0)
- Swift 4.1 -> version [**4.1.0**](https://github.com/freshOS/Arrow/releases/tag/4.1.0)
- Swift 4.2 -> version [**4.2.0**](https://github.com/freshOS/Arrow/releases/tag/4.2.0)
- Swift 5.0 -> version [**5.0.0**](https://github.com/freshOS/Arrow/releases/tag/5.0.0)
- Swift 5.1 -> version [**5.1.0**](https://github.com/freshOS/Arrow/releases/tag/5.1.0)
- Swift 5.1.3 -> version [**5.1.1**](https://github.com/freshOS/Arrow/releases/tag/5.1.1)

## Acknoledgments
This wouldn't exist without [YannickDot](https://github.com/YannickDot), [Damien-nd](https://github.com/damien-nd) and [maxkonovalov](https://github.com/maxkonovalov)

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>



### Backers
Like the project? Offer coffee or support us with a monthly donation and help us continue our activities :)

<a href="https://opencollective.com/freshos/backer/0/website" target="_blank"><img src="https://opencollective.com/freshos/backer/0/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/1/website" target="_blank"><img src="https://opencollective.com/freshos/backer/1/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/2/website" target="_blank"><img src="https://opencollective.com/freshos/backer/2/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/3/website" target="_blank"><img src="https://opencollective.com/freshos/backer/3/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/4/website" target="_blank"><img src="https://opencollective.com/freshos/backer/4/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/5/website" target="_blank"><img src="https://opencollective.com/freshos/backer/5/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/6/website" target="_blank"><img src="https://opencollective.com/freshos/backer/6/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/7/website" target="_blank"><img src="https://opencollective.com/freshos/backer/7/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/8/website" target="_blank"><img src="https://opencollective.com/freshos/backer/8/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/9/website" target="_blank"><img src="https://opencollective.com/freshos/backer/9/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/10/website" target="_blank"><img src="https://opencollective.com/freshos/backer/10/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/11/website" target="_blank"><img src="https://opencollective.com/freshos/backer/11/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/12/website" target="_blank"><img src="https://opencollective.com/freshos/backer/12/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/13/website" target="_blank"><img src="https://opencollective.com/freshos/backer/13/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/14/website" target="_blank"><img src="https://opencollective.com/freshos/backer/14/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/15/website" target="_blank"><img src="https://opencollective.com/freshos/backer/15/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/16/website" target="_blank"><img src="https://opencollective.com/freshos/backer/16/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/17/website" target="_blank"><img src="https://opencollective.com/freshos/backer/17/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/18/website" target="_blank"><img src="https://opencollective.com/freshos/backer/18/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/19/website" target="_blank"><img src="https://opencollective.com/freshos/backer/19/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/20/website" target="_blank"><img src="https://opencollective.com/freshos/backer/20/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/21/website" target="_blank"><img src="https://opencollective.com/freshos/backer/21/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/22/website" target="_blank"><img src="https://opencollective.com/freshos/backer/22/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/23/website" target="_blank"><img src="https://opencollective.com/freshos/backer/23/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/24/website" target="_blank"><img src="https://opencollective.com/freshos/backer/24/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/25/website" target="_blank"><img src="https://opencollective.com/freshos/backer/25/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/26/website" target="_blank"><img src="https://opencollective.com/freshos/backer/26/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/27/website" target="_blank"><img src="https://opencollective.com/freshos/backer/27/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/28/website" target="_blank"><img src="https://opencollective.com/freshos/backer/28/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/29/website" target="_blank"><img src="https://opencollective.com/freshos/backer/29/avatar.svg"></a>

### Sponsors
Become a sponsor and get your logo on our README on Github with a link to your site :)

<a href="https://opencollective.com/freshos/sponsor/0/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/1/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/2/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/3/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/4/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/5/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/6/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/7/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/8/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/9/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/9/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/10/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/10/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/11/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/11/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/12/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/12/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/13/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/13/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/14/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/14/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/15/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/15/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/16/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/16/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/17/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/17/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/18/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/18/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/19/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/19/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/20/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/20/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/21/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/21/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/22/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/22/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/23/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/23/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/24/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/24/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/25/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/25/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/26/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/26/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/27/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/27/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/28/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/28/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/29/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/29/avatar.svg"></a>
