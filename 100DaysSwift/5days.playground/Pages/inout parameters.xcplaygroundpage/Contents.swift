//: [Previous](@previous)

import Foundation

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)

print(myNum)
//: [Next](@next)
