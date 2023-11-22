//: [Previous](@previous)

import Foundation

let firstScore = 6
let secondScore = 4

firstScore == secondScore
firstScore != secondScore
firstScore < secondScore
firstScore >= secondScore

let str = "abcDEF"

for index in str.utf8 {
    print(index)// 97 98 99 68 69
}

"Taylor" < "Aaaaaaaa"

"A" > "A"

enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)
//: [Next](@next)
