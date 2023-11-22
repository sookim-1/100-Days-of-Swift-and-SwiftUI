//: [Previous](@previous)

import Foundation

struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

struct Family {
    var houseName: String

    init(name: String) {
        print("\(name) was born!")
        self.houseName = name
    }
}

let person = Person(name: "sookim")
let family = Family(name: "home")
family.houseName
//: [Next](@next)
