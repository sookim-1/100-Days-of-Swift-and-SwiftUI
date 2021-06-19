//: [Previous](@previous)

import Foundation

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")

repeat {
    print("This is false")
} while false

let numbers = [1, 2]
var random = numbers.shuffled()

while random == numbers {
    random = numbers.shuffled()
    print("랜덤")
}

let repeatNumbers = [1, 2]
var repeatRandom: [Int]

repeat {
    repeatRandom = repeatNumbers.shuffled()
    print("repeat랜덤")
} while repeatRandom == repeatNumbers

//: [Next](@next)
