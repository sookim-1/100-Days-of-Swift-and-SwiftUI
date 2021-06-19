//: [Previous](@previous)

import Foundation

var name: String? = "hello"

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

let song: String? = "Shake it Off"
if let unwrappedSong = song {
    print("The name has \(unwrappedSong.count) letters.")
}

var score: Int? = nil
score = 556
if let playerScore = score {
    print("You scored \(playerScore) points.")
}
//: [Next](@next)
