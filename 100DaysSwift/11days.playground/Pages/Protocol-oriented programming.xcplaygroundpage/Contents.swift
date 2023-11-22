//: [Previous](@previous)

import Foundation

protocol Identifiable {
    var id: String { get set }
    func identify()
}

extension Identifiable {
    var test: String {
        let doubleId = id + id
        return doubleId
    }
    func identify() {
        print("My ID is \(id).")
    }
}

struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.id //"twostraws"
twostraws.test //"twostrawstwostraws"
twostraws.identify() // My ID is twostraws.

//: [Next](@next)
