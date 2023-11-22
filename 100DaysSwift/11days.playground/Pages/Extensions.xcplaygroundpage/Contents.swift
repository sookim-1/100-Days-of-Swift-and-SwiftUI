//: [Previous](@previous)

import Foundation

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }

    func squared() -> Int {
        return self * self
    }
}

let number = 9

number.isEven // false
number.squared() // 81
//: [Next](@next)
