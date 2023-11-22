//: [Previous](@previous)

import Foundation

func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)

func quize(answer: String) -> (result: String, money: Int) {
    if answer == "sookim" {
        return ("ok", 100)
    }
    return ("no", 0)
}

print(quize(answer: "sookim"))

func doMath() -> Int {
    return 5 + 5
}

func doMoreMath() -> Int {
    5 + 5
}

doMath()
doMoreMath()
//: [Next](@next)
