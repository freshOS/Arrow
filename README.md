# Arrow
Dead simple Swift JSON Parsing

Spoiler Alert <3
---
```swift
identifier <-- json["id"]
name <-- json["name"]
stats <== json["stats"]
```

Swift Model
-
```swift
struct Profile {
    var identifier = 0
    var name = ""
    var stats = Stats()
}
```


Before (The Chaos)
-
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


WithArow Sanity preserved
-

```swift
extension Profile:ArrowParsable {
    init(json: JSON) {
        identifier <-- json["id"]
        name <-- json["name"]
        stats <== json["stats"]
    }
}
```

TL;DR
--
copy paste Arow.swift (no need for podSpec/carthage its only one file

//create a file MyModel + ArrowParsable {
//    //extension Profile:ArrowParsable {
//    init(json: JSON) {
//        identifier <-- json["id"]
//        name <-- json["name"]
//        // Can use . syntax
//        //        stats.numberOfFriends <-- json.valueForKeyPath("stats.numberOfFriends")
//        //        stats.numberOfFans <-- json.valueForKeyPath("stats.numberOfFans")
//        //
//        // But even better to refacto in sub objects \o/
//        stats <== json["stats"]
//    }
//}
//}

//3. let myModel = MyModel(json: json)
//$. there is no step 4
