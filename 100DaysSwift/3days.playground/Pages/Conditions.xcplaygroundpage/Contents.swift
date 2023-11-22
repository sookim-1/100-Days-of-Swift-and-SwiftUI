//: [Previous](@previous)

import Foundation
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 ||  firstCard - secondCard == 2{
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 && firstCard % secondCard == 2 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
//: [Next](@next)
