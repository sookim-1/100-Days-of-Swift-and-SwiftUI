//: [Previous](@previous)

import Foundation

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")
let singing = Activity.singing(volume: 2)

//: [Next](@next)
