//: [Previous](@previous)

import Foundation

struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let person = Person(id: "123456")
let person1 = Person(id: "123456789")

print(person?.id)
print(person1?.id)
//: [Next](@next)
