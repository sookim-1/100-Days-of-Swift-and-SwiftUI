//: [Previous](@previous)

import Foundation

let pythons: [String] = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles: Set<String> = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()


//: [Next](@next)
