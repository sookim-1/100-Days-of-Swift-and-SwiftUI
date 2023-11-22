//: [Previous](@previous)

import Foundation

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...2 {
    let person = Person()
    person.printGreeting()
}
//: [Next](@next)
