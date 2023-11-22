//: [Previous](@previous)

import Foundation

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

func omitting(external1 internal1: Bool = true) {
    if internal1 {
        print("a")
    }
    else {
        print("b")
    }
}
omitting()
omitting(external1: false)
// omitting(false) 에러남

//: [Next](@next)
