//: [Previous](@previous)

import Foundation

let driving: (String, Int) -> () = { (name: String, number: Int) in
    print("My Car is \(name) - \(number)")
}

driving("Tico", 213)

let calculateResult = { (answer: Int) in
    if answer == 42 {
        print("You're correct!")
    } else {
        print("Try again.")
    }
}

calculateResult(33)
//: [Next](@next)
