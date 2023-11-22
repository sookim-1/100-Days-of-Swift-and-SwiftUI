//: [Previous](@previous)

import Foundation

for i in 1 ..< 5 {
    print(i)
}
for i in 1 ... 5 {
    print(i)
}
let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[1..<2])
print(names[0...])
let score = 85
let a: ClosedRange<Int> = 1...3
print(a)
switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
//: [Next](@next)
