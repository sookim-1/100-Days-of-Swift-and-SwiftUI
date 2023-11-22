//: [Previous](@previous)

import Foundation

protocol Identifiable {
    var id: String { get set }
}

protocol editProtocol {
    var name: String { get }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

let user = User(id: "test")
displayID(thing: user)
//: [Next](@next)
