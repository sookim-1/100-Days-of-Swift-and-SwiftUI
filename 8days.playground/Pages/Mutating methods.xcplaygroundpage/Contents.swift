//: [Previous](@previous)

import Foundation

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

//let person = Person(name: "hey")
var person = Person(name: "hey")
person.name
person.makeAnonymous()
person.name


//: [Next](@next)
