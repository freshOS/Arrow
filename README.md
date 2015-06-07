# Arrow <--
Dead simple Swift JSON Parsing

## Features

- [x] Leaves your models clean
- [x] Struct friendly
- [x] Simple
- [x] Extensible
- [x] Easy to use

Why Another Swift JSON Parsing Library
--

Well the answer is prettry simple. All the others are simply not good enough.
Here is our requirements for a good Json Library :

- It should not force us to subclass our models. The fact that we get data as JSON is a DETAIL and should not leak in our app architecture (right uncle bob?! :p)
So there is no reason that using a particular library to parse Json would force us to come back to our pretty models
and subclass them with some obscure class. And what if your model aldready subclasses something, say NSManagedObject? well you're pretty much screwed :p

- Use Structs over Classes
As good swift citizens we want to use structs over classes for our models.

- easily extensible
- Be simple
- Be easy, not throwing obsucre syntax chain obscure functional operator all over the place


Characteristics  | Usual JSON Library | Arrow
------------- | ------------- | ----
Clean Model  | Content Cell | test
Simple  | Content Cell |  tsts


Ok Now show me the code
-

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

JSON File
--
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


Usual Swift JSON Parsing (Chaos)
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


With Arrow --> Sanity preserved
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
