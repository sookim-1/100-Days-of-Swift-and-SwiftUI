//: [Previous](@previous)

import Foundation

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user: String = username(for: 15) ?? "Anonymous"
let user1 = username(for: 1) ?? "Anonymous"
//: [Next](@next)
