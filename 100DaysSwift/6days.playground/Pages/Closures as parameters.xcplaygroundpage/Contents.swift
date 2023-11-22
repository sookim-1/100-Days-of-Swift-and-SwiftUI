//: [Previous](@previous)

import Foundation

let driving: () -> Void = {
    print("I'm driving in my car")
}

func travel(action: () -> ()) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

//travel(action: driving)
travel {
    print("I'm driving in my car")
}

let driveSafely = {
    return "I'm being a considerate driver"
}
func drive(using driving: () -> String) {
    print("Let's get in the car")
    print("\(driving())")
    print("We're there!")
}
drive(using: driveSafely)
//: [Next](@next)
