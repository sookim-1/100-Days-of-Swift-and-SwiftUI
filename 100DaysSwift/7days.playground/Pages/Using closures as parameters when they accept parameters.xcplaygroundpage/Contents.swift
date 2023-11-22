//: [Previous](@previous)

import Foundation

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

func travel1(action: (String) -> Void) {
    print("I'm getting ready to go.")
    //action("London")
    print("I arrived!")
}

travel1 { (fe : String) in
    print("hoell")
}
//: [Next](@next)
