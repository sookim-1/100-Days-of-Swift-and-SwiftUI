//: [Previous](@previous)

import Foundation

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)

func addArray(array: [Int]...) {
    for i in array {
        for j in i {
            print(j)
        }
    }
}

addArray(array: [1,2,3], [4,5,6])
//: [Next](@next)
