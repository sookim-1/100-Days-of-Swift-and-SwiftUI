//: [Previous](@previous)

import Foundation

struct Sport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
    
    var computedProperty: String {
        return "computedProperty"
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
print(chessBoxing.computedProperty)
//: [Next](@next)
